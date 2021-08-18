#if defined(VERT)


out vec4 starData; //rgb = star color, a = flag for whether or not this pixel is a star.

void render() {
	gl_Position = ftransform();
	starData = vec4(gl_Color.rgb, float(gl_Color.r == gl_Color.g && gl_Color.g == gl_Color.b && gl_Color.r > 0.0));
}

#if defined(DEFAULT)
void main() {
	render();
}
#endif // DEFAULT


#endif // VERT




#if defined(FRAG)


// Includes
#include "/lib/fog.glsl"
#include "/lib/common.glsl"

// Uniforms
uniform float viewHeight;
uniform float viewWidth;
uniform mat4 gbufferModelView;
uniform mat4 gbufferProjectionInverse;
uniform vec3 fogColor;
uniform vec3 skyColor;
uniform float blindness;
uniform sampler2D gaux1;

in vec4 starData; //rgb = star color, a = flag for whether or not this pixel is a star.

vec3 calcSkyColor(vec3 pos) {
	float upDot = dot(pos, gbufferModelView[1].xyz); //not much, what's up with you?
	float fog = fogify(max(upDot, 0), 0.025);
	vec3 color = mix(skyColor, fogColor, fog);
	return color;
}

RenderResult render() {
	vec3 color;
	if (starData.a > 0.5) {
		color = starData.rgb;
	} else {
		vec4 pos = vec4(gl_FragCoord.xy / vec2(viewWidth, viewHeight) * 2.0 - 1.0, 1.0, 1.0);
		pos = gbufferProjectionInverse * pos;
		color = calcSkyColor(normalize(pos.xyz)) * (1 - blindness);
	}

	RenderResult res = RenderResult(vec4(color, 1));
	return res;
}

#if defined(DEFAULT)
void main() {
	RenderResult res = render();
	/* DRAWBUFFERS:04 */
	gl_FragData[0] = res.color; //gcolor
	gl_FragData[1] = vec4(0); //colortex4
}
#endif // DEFAULT


#endif // FRAG
