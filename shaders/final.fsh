#version 150

// Preprocessors
#define FRAG

// Includes
#include "/lib/common.glsl"

// Uniforms
uniform sampler2D gcolor;
uniform sampler2D colortex4;

// Inputs
in vec2 texcoord;
in vec4 glcolor;
in float vertDist;

void main() {
	vec4 color = texture(gcolor, texcoord) * glcolor;
	vec4 bloomtex = texture(colortex4, texcoord) * glcolor;

	color.r *= 1.05;
	color.g *= 0.975;
	color.b *= 1.05;

	/* DRAWBUFFERS:40 */
	gl_FragData[0] = bloomtex; //colortex4
	gl_FragData[1] = color; //gcolor
}
