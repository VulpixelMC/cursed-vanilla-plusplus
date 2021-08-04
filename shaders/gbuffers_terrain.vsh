#version 150

// Preprocessors
#define VERT
#define TEXTURED
#define LIGHTMAP
#define FOG
#define USE_NORMALS

// Includes
#include "/program/base.glsl"

// Inputs
#if !defined(_MC_ENTITY)
#define _MC_ENTITY
in vec2 mc_Entity;
#endif

// Outputs
out float blockId;

void main() {
	RenderResult res = render();

	blockId = mc_Entity.x;
}
