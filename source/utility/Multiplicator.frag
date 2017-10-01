#version 300 es
precision highp float;
uniform sampler2D texture0;
uniform sampler2D texture1;
in vec2 fragmentTextureCoordinate;
out float outColor;

void main() {
	outColor = texture(texture0, fragmentTextureCoordinate).r * texture(texture1, fragmentTextureCoordinate).r;
}
