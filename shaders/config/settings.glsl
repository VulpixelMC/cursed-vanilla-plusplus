// Options
#define BLOOM_INTENSITY 1.75 // [1, 1.5, 1.75, 2]
// #define DEBUG
#define FLAT_NORMAL vec3(0, 1, 0) // The normal for flat "blocks" using the cross model
// #define OLD_BLOOM // The old kernel for the bloom effect
#define COLOR_SATURATION // Slightly increases the saturation

// Lighting
#define AMBIENT_STRENGTH 0.9 // [0.7, 0.8, 0.9]
#define DIFFUSE_X_STRENGTH 0.3 // [0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9]
#define DIFFUSE_Z_STRENGTH 0.4 // [0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9]
#define DIFFUSE_Y_STRENGTH 0.2 // [0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9]
