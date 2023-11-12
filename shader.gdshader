shader_type spatial;

uniform float screen_luminosity : hint_range(0, 2) = 1.0;

void fragment() {
    // Fetch the original color
    vec4 color = texture(SCREEN_TEXTURE, SCREEN_UV);

    // Adjust color based on screen luminosity
    color.rgb *= screen_luminosity;

    // Output the modified color
    COLOR = color;
}