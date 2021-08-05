#version 150

// Preprocessors
#define FRAG

// Includes
#include "/lib/common.glsl"
#include "/lib/constants.glsl"

// Uniforms
uniform sampler2D gcolor;
uniform sampler2D colortex4;

// Inputs
in vec2 texcoord;

void main() {
	// Bloom
	vec2 tex_offset = 1 / textureSize(colortex4, 0);
	vec3 result = texture(colortex4, texcoord).rgb;
	
	for (int i = 0; i < 21; i++) {
		result += texture(colortex4, texcoord + vec2(tex_offset.x * i, 0)).rgb;
		result += texture(colortex4, texcoord - vec2(tex_offset.x * i, 0)).rgb;
	}

	result /= 21;

	vec4 color = vec4(result, 1);

	/* DRAWBUFFERS:04 */
	gl_FragData[0] = texture(gcolor, texcoord); //gcolor
	gl_FragData[1] = color; //colortex4
}
