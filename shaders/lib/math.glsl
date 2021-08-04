// https://stackoverflow.com/a/63096094
float squareDist(vec3 a, vec3 b) {
	vec3 c = a - b;
	return dot(c, c);
}
