#version 150

// Preprocessors
#define FRAG

// Includes
#include "/lib/common.glsl"

// Uniforms
uniform sampler2D gtexture;

// Inputs
in vec2 texcoord;
in vec4 glcolor;
in float vertDist;

void main() {
	vec4 color = texture2D(gtexture, texcoord) * glcolor;
	color.r *= 1.05;
	color.g *= 0.975;
	color.b *= 1.05;
	setColor(color);
}
