// const float wetnessHalflife = 600;

float fogify(float x, float w) {
	return w / (x * x + w);
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
