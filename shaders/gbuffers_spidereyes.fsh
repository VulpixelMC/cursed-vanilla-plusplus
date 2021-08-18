#version 150

#define FRAG
#define TEXTURED

#include "/program/base.glsl"

void main() {
	RenderResult res = render();

	/* DRAWBUFFERS:04 */
	gl_FragData[0] = res.color; //gcolor
	gl_FragData[1] = res.color; //colortex4
}
