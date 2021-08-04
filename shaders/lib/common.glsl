#if defined(FRAG)

// Rendering data to be passed to the main method
struct RenderResult {
	vec4 color;
};

// Sets the gl_FragData[0] to the given color
void setColor(vec4 color) {
	/* DRAWBUFFERS:0 */
	gl_FragData[0] = color; //gcolor
}


#endif
