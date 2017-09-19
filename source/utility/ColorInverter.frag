#version 300 es
precision highp float;
uniform sampler2D texture0;
uniform sampler2D texture1;
in vec2 fragmentTextureCoordinate;
out float outColor;

void main() {
	float y = texture(texture0, fragmentTextureCoordinate).r;
	vec2 uv = texture(texture1, fragmentTextureCoordinate).rg;
	outColor = 1.0 - y;
}
