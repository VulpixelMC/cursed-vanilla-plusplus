#version 150

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

	// fading clouds
	glcolor.a *= smoothstep(sin(worldPos.y / 3), cos(worldPos.y / 2), worldPos.y / 2 - cameraPosition.y / 2) + 0.25;
}
