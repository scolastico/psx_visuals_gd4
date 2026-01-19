extends Node

var base_psx_material = preload("res://addons/psx_visuals_gd4/materials/mat_psx_default.tres")

func _enter_tree():
	get_tree().node_added.connect(_on_node_added)

func _on_node_added(node):
	if node is GeometryInstance3D:
		if node is Label3D:
			return
		
		# Check if this node specifically is disabled
		if node.has_meta("psx_disable") and node.get_meta("psx_disable") == true:
			return
			
		# Check if any parent has "psx_disable_children"
		if _is_inside_disabled_branch(node):
			return

		# Defer the call slightly to ensure the mesh and materials are fully loaded
		_apply_ps1_shader.call_deferred(node)

# Helper function to crawl up the tree and check for child-disabling flags
func _is_inside_disabled_branch(node: Node) -> bool:
	var parent = node.get_parent()
	while parent:
		if parent.has_meta("psx_disable_children") and parent.get_meta("psx_disable_children") == true:
			return true
		parent = parent.get_parent()
	return false

func _apply_ps1_shader(node: GeometryInstance3D):
	# Re-check metadata inside deferred call in case it was added during the same frame
	if node.has_meta("psx_disable") or _is_inside_disabled_branch(node):
		return

	var mesh = node.mesh
	if not mesh:
		return
		
	for i in range(mesh.get_surface_count()):
		var original_mat = node.get_active_material(i)
		
		# Skip if it's already a PSX shader
		if original_mat is ShaderMaterial and original_mat.shader == base_psx_material.shader:
			continue

		var new_mat = base_psx_material.duplicate()

		if original_mat is StandardMaterial3D:
			# 1. Copy the Albedo Texture
			if original_mat.albedo_texture:
				new_mat.set_shader_parameter("albedo", original_mat.albedo_texture)
			
			# 2. Copy the Albedo Tint/Color
			new_mat.set_shader_parameter("albedo_tint", original_mat.albedo_color)
			
			# 3. Handle Emission
			if original_mat.emission_enabled:
				new_mat.set_shader_parameter("emission", original_mat.emission_texture)
				new_mat.set_shader_parameter("emission_tint", original_mat.emission)
				
		node.set_surface_override_material(i, new_mat)
