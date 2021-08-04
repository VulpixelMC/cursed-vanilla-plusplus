#if defined(VERT)

#if !defined(_INCLUDE_COMMON_VERT)
#define _INCLUDE_COMMON_VERT


// Rendering data to be passed to the main method
struct RenderResult {
	vec4 position;
};


#endif // _INCLUDE_COMMON_VERT

#endif // VERT



#if defined(FRAG)

#if !defined(_INCLUDE_COMMON_FRAG)
#define _INCLUDE_COMMON_FRAG


// Rendering data to be passed to the main method
struct RenderResult {
	vec4 color;
};


#endif // _INCLUDE_COMMON_FRAG

#endif // FRAG
