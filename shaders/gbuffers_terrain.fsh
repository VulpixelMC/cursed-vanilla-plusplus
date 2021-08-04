#version 150

// Preprocessors
#define FRAG
#define TEXTURED
#define LIGHTMAP
#define FOG

// Includes
#include "/program/base.glsl"

// Inputs
in float blockId;

void main() {
	RenderResult res = render();

	/* DRAWBUFFERS:04 */
	gl_FragData[0] = res.color; //gcolor
	gl_FragData[1] = vec4(blockId);
}
