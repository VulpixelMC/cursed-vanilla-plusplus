float getLuminance(vec3 color) {
	return dot(color, vec3(0.2125, 0.7154, 0.0721));
}
