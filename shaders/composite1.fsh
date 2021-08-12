#version 150

// Preprocessors
#define FRAG

// Includes
#include "/lib/bloom.glsl"

void main() {
	BloomResult res = calcBloom(true);

	/* DRAWBUFFERS:04 */
	gl_FragData[0] = texture(gcolor, texcoord); //gcolor
	gl_FragData[1] = res.color; //colortex4
}
