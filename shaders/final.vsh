#version 150 compatibility

// Uniforms
uniform mat4 gbufferModelView;
uniform mat4 gbufferModelViewInverse;

// Outputs
out vec2 texcoord;
out vec4 glcolor;

void main() {
	vec4 position = gbufferModelViewInverse * (gl_ModelViewMatrix * gl_Vertex);
	gl_Position = gl_ProjectionMatrix * gbufferModelView * position;

	glcolor = gl_Color;

	texcoord = gl_MultiTexCoord0.st;
}
