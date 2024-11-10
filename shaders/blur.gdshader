shader_type canvas_item;

uniform sampler2D iChannel0 : hint_screen_texture;

uniform float Directions = 16.0; // BLUR DIRECTIONS (Default 16.0 - More is better but slower)
uniform float Quality = 2.9; // BLUR QUALITY (Default 4.0 - More is better but slower)
uniform float Size = 8.0; // BLUR SIZE (Radius)

void fragment()
{
    vec2 Radius = Size / (1.0 / SCREEN_PIXEL_SIZE);

    // Pixel colour
    vec4 Color = texture(iChannel0, UV);

    // Blur calculations
    for( float d=0.0; d<2.0*PI; d+=(2.0*PI)/Directions)
    {
		for(float i=1.0/Quality; i<=1.0; i+=1.0/Quality)
        {
			Color += texture( iChannel0, UV+vec2(cos(d),sin(d))*Radius*i);
        }
    }
    // Output to screen
    Color /= Quality * Directions - 15.0;
    COLOR =  Color;
}