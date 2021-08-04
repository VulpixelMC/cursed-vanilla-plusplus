#version 150

// Preprocessors
#define FRAG

// Includes
#include "/lib/common.glsl"

// Constants
const float weight[5] = float[] (0.227027, 0.1945946, 0.1216216, 0.054054, 0.016216);

// Uniforms
uniform sampler2D gtexture;
uniform sampler2D gaux1;

// Inputs
in vec2 texcoord;
in vec4 glcolor;
in float vertDist;

void main() {
	// Bloom
	vec2 tex_offset = 1 / textureSize(gtexture, 0);
	vec3 result;

	vec4 blockId = texture(gaux1, texcoord);

	if (blockId.r == 0 || blockId.r == 6) {
		result = texture(gtexture, texcoord).rgb * weight[0];

		for (int i = 1; i < 5; i++) {
			result += texture(gtexture, texcoord + vec2(tex_offset.x * i, 0)).rgb * weight[i];
			result += texture(gtexture, texcoord - vec2(tex_offset.x * i, 0)).rgb * weight[i];
		}
	} else {
		result = texture(gtexture, texcoord).rgb;
	}

	vec4 color = vec4(result, 1) * glcolor;

	/* DRAWBUFFERS:04 */
	gl_FragData[0] = color; //gcolor
	gl_FragData[1] = blockId;
}
