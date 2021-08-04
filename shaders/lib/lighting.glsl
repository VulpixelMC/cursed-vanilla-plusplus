// calculates simple lighting from vanilla
float calcSimpleLighting(vec3 normal) {
	// NOTE: This is as close to vanilla as XorDev can get it. It's not perfect, but it's close.
	return 0.8 - 0.25 * abs(normal.x * 0.9 + normal.z * 0.3) + normal.y * 0.2;
}
