shader_type spatial;

uniform vec2 light_position : hint_range(-100, 100) = vec2(0.0, 0.0); # to set 
uniform float light_radius : hint_range(0, 100) = 50.0; # to set 
uniform float light_intensity : hint_range(0, 2) = 1.0; # to set 
uniform float screen_luminosity : hint_range(0, 2) = 1.0; # to set 

void vertex() {
    vec4 model_space = MODELVIEW_MATRIX * vec4(VERTEX, 1.0);
    vec2 view_space = model_space.xy;

    float distance = length(view_space - light_position);

    VERTEX.x = distance;
}

void fragment() {
    float intensity = clamp(1.0 - (VERTEX.x / light_radius), 0.0, 1.0);
    intensity = pow(intensity, light_intensity);

    intensity *= screen_luminosity; # from LuminosityFeature.gd

    COLOR.rgb *= intensity;
}