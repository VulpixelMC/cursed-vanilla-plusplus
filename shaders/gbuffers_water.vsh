#version 150

// Preprocessors
#define VERT
#define TEXTURED
#define LIGHTMAP
#define FOG

// Includes
#include "/program/base.glsl"
#include "/lib/common.glsl"

void main() {
	RenderResult res = render();

	// Calculate normal
	vec3 normal = gl_NormalMatrix * gl_Normal;
	float light = calcSimpleLighting(normal);
}
