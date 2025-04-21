#version 150 compatibility

#define FRAG
#define TEXTURED

#include "/program/base.glsl"

void main() {
	RenderResult res = render();

	/* RENDERTARGETS: 0,4 */
	gl_FragData[0] = res.color; //gcolor
	gl_FragData[1] = res.color; //colortex4
}
