shader_type spatial;
render_mode blend_mix, vertex_lighting, depth_draw_always, diffuse_lambert, specular_occlusion_disabled, specular_disabled, shadows_disabled, fog_disabled, cull_disabled;

#include "res://addons/psx_visuals_gd4/shaders/psx.gdshaderinc"

// If enabled, this approximates the correct normals for backfaces, as if the mesh is double-sided.
uniform bool flip_backface_normals = true;

void vertex() {
	psx_compute_vertex(VERTEX, COLOR.rgb, UV);

	if (flip_backface_normals) {
		psx_compute_backface_normal(VERTEX, NORMAL);
	}
}

void fragment() {
	psx_compute_fragment(UV, ALBEDO, ALPHA, EMISSION);

	SPECULAR = 0.0;
	ROUGHNESS = 0.0;
	METALLIC = 0.0;
	AO = 1.0;
	NORMAL = NORMAL;
}
