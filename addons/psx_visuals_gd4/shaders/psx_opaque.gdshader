shader_type spatial;
render_mode blend_mix, vertex_lighting, diffuse_lambert, specular_occlusion_disabled, specular_disabled, shadows_disabled, fog_disabled;

#include "res://addons/psx_visuals_gd4/shaders/psx.gdshaderinc"

uniform float alpha_scissor_threshold: hint_range(0.0, 1.0, 0.01) = 0.5;

void vertex() {
	psx_compute_vertex(VERTEX, COLOR.rgb, UV);
}

void fragment() {
	psx_compute_fragment(UV, ALBEDO, ALPHA, EMISSION);
	
	ALPHA_SCISSOR_THRESHOLD = alpha_scissor_threshold;
	SPECULAR = 0.0;
	ROUGHNESS = 0.0;
	METALLIC = 0.0;
	AO = 1.0;
}
