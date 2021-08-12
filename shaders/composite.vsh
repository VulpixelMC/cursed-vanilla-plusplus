#version 150

// Preprocessors
#define VERT

// Includes
#include "/lib/bloom.glsl"

// Uniforms
uniform mat4 gbufferModelView;
uniform mat4 gbufferModelViewInverse;

void main() {
	vec4 position = gbufferModelViewInverse * (gl_ModelViewMatrix * gl_Vertex);
	gl_Position = gl_ProjectionMatrix * gbufferModelView * position;

	glcolor = gl_Color;

	texcoord = gl_MultiTexCoord0.st;

	vertDist = length(position.xyz);
}
