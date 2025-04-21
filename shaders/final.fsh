#version 150 compatibility

// Preprocessors
#define FRAG

// Includes
#include "/config/settings.glsl"
#include "/lib/common.glsl"

// Uniforms
uniform sampler2D colortex0;
uniform sampler2D colortex4;

// Inputs
in vec2 texcoord;
in vec4 glcolor;

void main() {
	vec4 color = texture(colortex0, texcoord) * glcolor;
	vec4 bloomtex = texture(colortex4, texcoord);

	// add bloom effect
	color.rgb += bloomtex.rgb;

	#ifdef COLOR_SATURATION
	color.r *= 1.025;
	color.b *= 1.025;
	#endif // COLOR_SATURATION

	/* RENDERTARGETS: 0 */
	gl_FragData[0] = color; //gcolor
}
