#if !defined(_INCLUDE_FOG)
#define _INCLUDE_FOG)
uniform float far;

// const float wetnessHalflife = 600;

float fogify(float x, float w) {
	return w / (x * x + w);
}

// make a fog fade effect using smoothstep
float fogFade(float start, float end, float vertDist) {
	return smoothstep(gl_Fog.start * start, gl_Fog.end * end, vertDist);
}

// fogFade but it doesn't depend on gl_Fog if the render distance is > 24
float specialFade(float start, float end, float vertDist) {
	if (far / 16 > 24) {
		return smoothstep(start * 256, end * 256, vertDist);
	} else {
		return fogFade(start, end, vertDist);
	}
}

// The player's visibility multiplier when underwater
// float underwaterVisibility(float submergeTime) {
// 	if (submergeTime >= wetnessHalflife / 20) {
// 		return 1.;
// 	} else {
// 		float x = clamp(submergeTime / 100, 0, 1);
// 		float y = submergeTime < 100 ? 0 : clamp((submergeTime - 100) / 500, 0, 1);
// 		return x * 0.6 + y * 0.39999998;
// 	}
// }

#endif // _INCLUDE_FOG
