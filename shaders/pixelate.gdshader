shader_type canvas_item;

uniform float pixel_size : hint_range(0.00,1, 0.01) = 0.5;

uniform sampler2D SCREEN_TEXTURE;

void fragment() {
	//Self-pixelation
	vec2 pixelNumber = vec2(textureSize(SCREEN_TEXTURE, 0)) * pixel_size;
    vec2 pixelatedUV = round(SCREEN_UV * pixelNumber) /pixelNumber;
	COLOR = texture(SCREEN_TEXTURE, pixelatedUV);
}