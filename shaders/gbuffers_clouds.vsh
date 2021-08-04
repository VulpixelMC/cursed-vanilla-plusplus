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
uniform vec3 cameraPosition;

void main() {
	RenderResult res = render();

	glcolor = gl_Color;

	vec3 viewPos = (gl_ModelViewMatrix * gl_Vertex).xyz;
	vec3 feetPos = (gbufferModelViewInverse * vec4(viewPos, 1)).xyz;
	vec3 worldPos = feetPos + cameraPosition;

	// fading clouds
	glcolor.a *= smoothstep(sin(worldPos.y / 3), cos(worldPos.y / 2), worldPos.y / 4 - cameraPosition.y / 4) + 0.25;
}
