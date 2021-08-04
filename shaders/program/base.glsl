#if defined(VERT)

#if !defined(_INCLUDE_BASE_VERT)
#define _INCLUDE_BASE_VERT

// Options
#define FLAT_NORMAL vec3(0, 1, 0) // The normal for flat "blocks" using the cross model

// Preprocessors

// Includes
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

// Guards
#define _GBUFFERMODELVIEW
#define _GBUFFERMODELVIEWINVERSE
#define _MC_ENTITY
#define _LMCOORD
#define _TEXCOORD
#define _VERTDIST

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
}
#endif


#endif // _INCLUDE_BASE_VERT

#endif // VERT



#if defined(FRAG)

#if !defined(_INCLUDE_BASE_FRAG)
#define _INCLUDE_BASE_FRAG


// Options
// #define DEBUG

// Preprocessors

// Includes
#include "/lib/fog.glsl"
#include "/lib/common.glsl"

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

// Guards
#define _LIGHTMAP
#define _GTEXTURE
#define _ENTITYCOLOR
#define _FOGCOLOR
#define _SKYCOLOR
#define _ISEYEINWATER
#define _MC_ENTITY
#define _LMCOORD
#define _TEXCOORD
#define _VERTDIST

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
	setColor(res.color);
}
#endif


#endif // _INCLUDE_BASE_FRAG

#endif // FRAG
