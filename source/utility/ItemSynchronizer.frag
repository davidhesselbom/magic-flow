#version 300 es
precision highp float;
uniform sampler2D texture0;
uniform sampler2D texture1;
in vec2 fragmentTextureCoordinate;
out float outColor;

void main() {
	float result = texture(texture0, fragmentTextureCoordinate).r;
	if (result > 0.0)
		result = texture(texture1, floor(fragmentTextureCoordinate)).r;
	outColor = result;
}
