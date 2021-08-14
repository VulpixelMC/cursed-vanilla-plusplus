#if !defined(_INCLUDE_LIGHTING)
#define _INCLUDE_LIGHTING

// Includes
#include "/config/settings.glsl"

// calculates ambient lighting
float calcAmbient(float light) {
	return AMBIENT_STRENGTH * light;
}

// calculates simple diffuse lighting
float calcSimpleDiffuse(vec3 normal) {
	return abs(normal.x * DIFFUSE_X_STRENGTH + normal.z * DIFFUSE_Z_STRENGTH) + normal.y * DIFFUSE_Y_STRENGTH;
}

// calculates specular map
// float calcSpecular(vec3 normal) {}

// calculates simple lighting from vanilla
float calcSimpleVanillaLighting(vec3 normal) {
	// NOTE: This is as close to vanilla as XorDev can get it. It's not perfect, but it's close.
	return 0.8 - 0.25 * abs(normal.x * 0.9 + normal.z * 0.3) + normal.y * 0.2;
}

// calculate simple lighting
float calcSimpleLighting(vec3 normal) {
	float light = 1;
	
	// calculate ambient lighting
	light = calcAmbient(light);

	// calculate diffuse
	// how much the diffuse is multiplied by to give a better blend effect
	float blendFactor = 0.2 / AMBIENT_STRENGTH;
	light -= blendFactor * calcSimpleDiffuse(normal);
	
	// calculate specular
	// no

	return light;
}

#endif // _INCLUDE_LIGHTING
