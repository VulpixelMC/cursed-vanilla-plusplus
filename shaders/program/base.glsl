#if defined(VERT)

#if !defined(_INCLUDE_BASE_VERT)
#define _INCLUDE_BASE_VERT


// Preprocessors

// Includes
#include "/config/settings.glsl"
#include "/lib/lighting.glsl"
#include "/lib/common.glsl"

// Uniforms
uniform mat4 gbufferModelView;
uniform mat4 gbufferModelViewInverse;

// Inputs
in vec2 mc_Entity;

// Outputs
out vec2 lmcoord;
out vec2 texcoord;
out vec4 glcolor;
out float vertDist;
out float blockId;

// Guards
#define _GBUFFERMODELVIEW
#define _GBUFFERMODELVIEWINVERSE
#define _MC_ENTITY
#define _LMCOORD
#define _TEXCOORD
#define _VERTDIST
#define _BLOCKID

RenderResult render() {
	vec4 position = gbufferModelViewInverse * (gl_ModelViewMatrix * gl_Vertex);
	#if defined(FOG)
	vec3 blockPos = position.xyz;
	vertDist = length(blockPos);
	gl_Position = gl_ProjectionMatrix * gbufferModelView * position;
	#else
	gl_Position = ftransform();
	#endif

	float light;

	#if defined(USE_NORMALS)
	// Calculate normal
	vec3 normal = gl_NormalMatrix * gl_Normal;
	// https://github.com/XorDev/XorDevs-Default-Shaderpack/blob/c13319fb7ca1a178915fba3b18dee47c54903cc3/shaders/gbuffers_textured.vsh#L39
	// Use flat for flat "blocks" or world space normal for solid blocks.
	normal = (mc_Entity.x == 4) ? FLAT_NORMAL : (gbufferModelViewInverse * vec4(normal, 0)).xyz;

	// https://github.com/XorDev/XorDevs-Default-Shaderpack/blob/c13319fb7ca1a178915fba3b18dee47c54903cc3/shaders/gbuffers_textured.vsh#L42
	// calculate simple lighting
	// light = calcSimpleVanillaLighting(normal);
	light = calcSimpleLighting(normal);
	#else
	// Don't apply lighting
	light = 1;
	#endif

	#if defined(TEXTURED)
	texcoord = (gl_TextureMatrix[0] * gl_MultiTexCoord0).xy;
	#endif
	
	#if defined(LIGHTMAP)
	lmcoord = (gl_TextureMatrix[1] * gl_MultiTexCoord1).xy;
	#endif

	#if !defined(NO_COLOR)
	#if defined(TEXTURED)
	glcolor = vec4(gl_Color.rgb * light, gl_Color.a);
	#else
	glcolor = gl_Color;
	#endif // TEXTURED
	#endif // NO_COLOR

	RenderResult res = RenderResult(position);
	return res;
}

#if defined(DEFAULT)
void main() {
	RenderResult res = render();

	blockId = mc_Entity.x;
}
#endif


#endif // _INCLUDE_BASE_VERT

#endif // VERT



#if defined(FRAG)

#if !defined(_INCLUDE_BASE_FRAG)
#define _INCLUDE_BASE_FRAG


// Preprocessors

// Includes
#include "/config/settings.glsl"
#include "/lib/fog.glsl"
#include "/lib/common.glsl"
#include "/lib/color.glsl"

// Constants

// Uniforms
uniform sampler2D lightmap;
uniform sampler2D gtexture;
uniform vec4 entityColor;
uniform vec3 fogColor;
uniform vec3 skyColor;
uniform int isEyeInWater;

// Inputs
in vec2 lmcoord;
in vec2 texcoord;
in vec4 glcolor;
in float vertDist;
in float blockId;

// Guards
#define _LIGHTMAP
#define _GTEXTURE
#define _ENTITYCOLOR
#define _FOGCOLOR
#define _SKYCOLOR
#define _ISEYEINWATER
#define _LMCOORD
#define _TEXCOORD
#define _VERTDIST
#define _BLOCKID

RenderResult render() {
	vec4 color;
	#if defined(TEXTURED)
	color = texture(gtexture, texcoord) * glcolor;
	#else
	color = glcolor;
	#endif

	vec3 light;

	// calculate lighting
	#if defined(LIGHTMAP)
	// https://github.com/XorDev/XorDevs-Default-Shaderpack/blob/c13319fb7ca1a178915fba3b18dee47c54903cc3/shaders/gbuffers_textured.fsh#L35
	light = texture(lightmap, lmcoord).rgb;
	#else
	light = vec3(1);
	#endif

	color.rgb *= light;

	// apply mob entity flashes
	#if defined(ENTITY_COLOR)
	color.rgb = mix(color.rgb, entityColor.rgb, entityColor.a);
	#endif

	// render fog
	#if defined(FOG)

	// calculate fog
	float fog = smoothstep(gl_Fog.start * 1.3, gl_Fog.end * 1.3, vertDist);

	color.rgb = mix(color.rgb, fogColor.rgb, fog);

	#endif // FOG

	RenderResult res = RenderResult(color);
	return res;
}

#if defined(DEFAULT)
void main() {
	RenderResult res = render();

	// raw unmodified pixel data
	vec4 rawColor = texture(gtexture, texcoord);
	// what the hell do i call this
	float foobarfuck = (getLuminance(rawColor.rgb) * BLOOM_BRIGHTNESS);
	float textureIntensity = (1.75 - BLOOM_INTENSITY / foobarfuck);

	/* DRAWBUFFERS:04 */
	// only add the emissive blocks to the bloom buffer
	//  so we don't apply bloom to everything
	if (equals(blockId, 5)) { // Emissive Blocks
		gl_FragData[0] = res.color * textureIntensity; //gcolor
		gl_FragData[1] = res.color; //colortex4
	} else if (equals(blockId, 6)) { // Torches
		// check if the pixel should be lit
		if (getLuminance(rawColor.rgb) > 0.5125) {
			gl_FragData[0] = res.color * textureIntensity; //gcolor
			gl_FragData[1] = res.color; //colortex4
		} else {
			gl_FragData[0] = res.color; //gcolor
			gl_FragData[1] = vec4(0); //colortex4
		}
	} else {
		gl_FragData[0] = res.color; //gcolor
		gl_FragData[1] = vec4(0); //colortex4
	}
}
#endif


#endif // _INCLUDE_BASE_FRAG

#endif // FRAG
