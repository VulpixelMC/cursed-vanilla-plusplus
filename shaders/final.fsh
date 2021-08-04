#version 150

// Preprocessors
#define FRAG

// Includes
#include "/lib/common.glsl"

// Uniforms
uniform sampler2D gtexture;
uniform sampler2D gaux1;

// Inputs
in vec2 texcoord;
in vec4 glcolor;
in float vertDist;

void main() {
	vec4 color = texture(gtexture, texcoord) * glcolor;
	vec4 blockId = texture(gaux1, texcoord);

	color.r *= 1.05;
	color.g *= 0.975;
	color.b *= 1.05;

	/* DRAWBUFFERS:04 */
	gl_FragData[0] = color; //gcolor
	gl_FragData[1] = blockId;
}
