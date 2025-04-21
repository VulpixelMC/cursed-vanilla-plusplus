#if defined(VERT)
#if !defined(_INCLUDE_BLOOM_VERT)
#define _INCLUDE_BLOOM_VERT


// Outputs
out vec2 texcoord;
out vec4 glcolor;
out float vertDist;


#endif // _INCLUDE_BLOOM_VERT
#endif // VERT



#if defined(FRAG)
#if !defined(_INCLUDE_BLOOM_FRAG)
#define _INCLUDE_BLOOM_FRAG


// Includes
#include "/config/settings.glsl"
#include "/lib/common.glsl"
#include "/lib/constants.glsl"

// Uniforms
uniform sampler2D colortex0;
uniform sampler2D colortex4;
uniform float viewWidth;
uniform float viewHeight;

// Inputs
in vec2 texcoord;
in vec4 glcolor;

struct BloomResult {
	vec4 color;
};

vec2 dirX(float offset, float i) {
	return vec2(offset * i, 0);
}

vec2 dirY(float offset, float i) {
	return vec2(0, offset * i);
}

BloomResult calcBloom(bool horizontal) {
	vec2 tex_offset = 1 / vec2(viewWidth, viewHeight);
	vec3 result = vec3(0);
	float weightSum = 0;
	
	for (int i = -KERNEL_SIZE; i < KERNEL_SIZE; i++) {
		float weight = weights[abs(i)];
		vec2 dir = horizontal ? dirY(tex_offset.y, i) : dirX(tex_offset.x, i);

		result += texture(colortex4, texcoord + dir).rgb * weight * ((BLOOM_INTENSITY * 0.75) / (horizontal ? 1.5 : 1));
		weightSum += weight;
	}

	vec3 color = result / weightSum;

	BloomResult res = BloomResult(vec4(color, 1));

	return res;
}


#endif // _INCLUDE_BLOOM_FRAG
#endif // FRAG
