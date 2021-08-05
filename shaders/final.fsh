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

void main() {
	vec4 color = texture(gcolor, texcoord) * glcolor;
	vec4 bloomtex = texture(colortex4, texcoord) * glcolor;

	// add bloom effect
	color.rgb += bloomtex.rgb;

	color.r *= 1.05;
	color.g *= 0.975;
	color.b *= 1.05;

	/* DRAWBUFFERS:0 */
	gl_FragData[0] = color; //gcolor
}
