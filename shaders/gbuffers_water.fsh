#version 150

// Preprocessors
#define FRAG
#define LIGHTMAP

// Includes
#include "/program/base.glsl"
#include "/lib/fog.glsl"

// Inputs

void main() {
	RenderResult res = render();

	res.color.a *= 1.25;
	res.color *= texture(gtexture, texcoord);
	
	// calculate light fade
	float fadeLight = specialFade(0.25, 1.2, vertDist);
	res.color.rgb = mix(res.color.rgb * 0.9, skyColor.rgb, fadeLight);

	// calculate dark fade
	// float fadeDark = specialFade(0.125, 0.25, vertDist);
	// res.color.rgb = mix(vec3(0.9) * res.color.rgb, res.color.rgb, fadeDark);

	// calculate fog
	float fog = fogFade(1.3, 1.3, vertDist);
	res.color.rgb = mix(res.color.rgb, fogColor.rgb, fog);

	/* DRAWBUFFERS:0 */
	gl_FragData[0] = res.color;
}
