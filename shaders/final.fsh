#version 150

// Preprocessors
#define FRAG

// Includes
#include "/config/settings.glsl"
#include "/lib/common.glsl"

// Uniforms
uniform sampler2D gcolor;
uniform sampler2D colortex4;

// Inputs
in vec2 texcoord;
in vec4 glcolor;

void main() {
	vec4 color = texture(gcolor, texcoord) * glcolor;
	vec4 bloomtex = texture(colortex4, texcoord);

	// add bloom effect
	color.rgb += bloomtex.rgb;

	#ifdef COLOR_SATURATION
	color.r *= 1.025;
	color.b *= 1.025;
	#endif // COLOR_SATURATION

	/* DRAWBUFFERS:0 */
	gl_FragData[0] = color; //gcolor
}
