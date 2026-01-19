@tool extends EditorPlugin

const AUTOLOAD_NAME := "PsxVisualsGd4AutoLoad"
const AUTOAPPLY_NAME := "PsxVisualsGd4AutoApply"

func _enable_plugin() -> void:
	add_autoload_singleton(AUTOLOAD_NAME, "res://addons/psx_visuals_gd4/scripts/AutoLoad.gd")
	add_autoload_singleton(AUTOAPPLY_NAME, "res://addons/psx_visuals_gd4/scripts/AutoApply.gd")

	# Initialize globals immediately so errors don't pop up on first run
	Psx.touch_shader_globals()

func _disable_plugin() -> void:
	remove_autoload_singleton(AUTOLOAD_NAME)
	remove_autoload_singleton(AUTOAPPLY_NAME)
