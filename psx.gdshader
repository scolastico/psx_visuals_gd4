shader_type spatial;
render_mode blend_mix, specular_occlusion_disabled, specular_disabled, vertex_lighting, cull_disabled, depth_draw_always;

#include "uid://bbm41nyy2th3f"

global uniform float psx_affine_strength;
global uniform float psx_snap_distance;
global uniform int psx_bit_depth;

uniform sampler2D albedo: hint_default_white, filter_nearest;
uniform vec3 albedo_tint: source_color = vec3(1);
uniform vec4 emission: source_color = vec4(1,1,1,0);

varying float affine_distance;
varying vec2 affine_uv_scaled;

void vertex() {
	VERTEX = snap(VERTEX, MODELVIEW_MATRIX, psx_snap_distance);

    affine_distance = length((MODELVIEW_MATRIX * vec4(VERTEX, 1.0)).xyz);
    affine_uv_scaled = UV * affine_distance;
}

void fragment() {
	vec2 affine_uv = affine_uv_scaled / affine_distance;

	float bit_levels = float((1 << psx_bit_depth) - 1);
	float dither_value = dither(FRAGCOORD.xy);

	vec4 color = texture(albedo, mix(UV, affine_uv, psx_affine_strength)) * vec4(albedo_tint, 1.0);
	color = floor((color + dither_value / bit_levels) * bit_levels) / bit_levels;
	ALBEDO = color.rgb;
	ALPHA = color.a;

	EMISSION = ALBEDO * emission.rgb * emission.a;

	SPECULAR = 0.0;
	ROUGHNESS = 0.0;
	METALLIC = 0.0;
	AO = 1.0;
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
