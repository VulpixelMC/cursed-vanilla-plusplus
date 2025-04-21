#version 150 compatibility

// Preprocessors
#define VERT
#define TEXTURED
#define NO_COLOR
#define FOG

// Includes
#include "/program/base.glsl"
#include "/lib/common.glsl"

// Uniforms
#if !defined(_CAMERAPOSITION)
uniform vec3 cameraPosition;
#endif

// Guards
#define _CAMERAPOSITION;

void main() {
	RenderResult res = render();

	glcolor = gl_Color;

	vec3 viewPos = (gl_ModelViewMatrix * gl_Vertex).xyz;
	vec3 feetPos = (gbufferModelViewInverse * vec4(viewPos, 1)).xyz;
	vec3 worldPos = feetPos + cameraPosition;

	// add alpha before applying fade
	glcolor.a += 0.25;

	// fading clouds
	glcolor.a *= smoothstep(cos(worldPos.y), sin(worldPos.y), worldPos.y / 8 - cameraPosition.y / 8);
}
