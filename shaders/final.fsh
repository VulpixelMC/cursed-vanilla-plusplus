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
	color.r *= 1.15;
	color.g *= 1.075;
	color.b *= 1.2;
	setColor(color);
}
