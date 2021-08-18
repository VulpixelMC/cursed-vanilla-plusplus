#if !defined(_INCLUDE_COMMON_FRAG)
#define _INCLUDE_COMMON_FRAG


// Strict equals for floats; accounts for floating point errors when comparing floats
bool equals(float x, float y) {
	return abs(x - y) < 0.00001;
}

#if defined(VERT)


// Rendering data to be passed to the main method
struct RenderResult {
	vec4 position;
};


#endif // VERT



#if defined(FRAG)


// Rendering data to be passed to the main method
struct RenderResult {
	vec4 color;
};


#endif // FRAG



#endif // _INCLUDE_COMMON_FRAG
