#version 150 compatibility

// Preprocessors
#define FRAG

// Includes
#include "/lib/bloom.glsl"

void main() {
	BloomResult res = calcBloom(false);

	/* RENDERTARGETS: 0,4 */
	gl_FragData[0] = texture(colortex0, texcoord); //gcolor
	gl_FragData[1] = res.color; //colortex4
}
