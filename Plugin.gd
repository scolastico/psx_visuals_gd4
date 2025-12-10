
@tool extends EditorPlugin

const AUTOLOAD_NAME := "PSXScreenEffects"
const AUTOLOAD_PATH := "res://addons/psx_visuals/scripts/PSXAutoload.gd"

const GLOBAL_VAR_AFFINE := "shader_globals/psx_affine_strength"
const GLOBAL_VAR_BIT_DEPTH := "shader_globals/psx_bit_depth"
const GLOBAL_VAR_FOG_COLOR := "shader_globals/psx_fog_color"
const GLOBAL_VAR_FOG_FAR := "shader_globals/psx_fog_near"
const GLOBAL_VAR_FOG_NEAR := "shader_globals/psx_fog_far"
const GLOBAL_VAR_SNAP := "shader_globals/psx_snap_size"

func _enable_plugin() -> void:
	add_autoload_singleton(AUTOLOAD_NAME, AUTOLOAD_PATH)

	var any_setting_changed := false

	if not ProjectSettings.has_setting(GLOBAL_VAR_AFFINE):
		ProjectSettings.set_setting(GLOBAL_VAR_AFFINE, {
			"type": "float",
			"value": 1.0
		})
		any_setting_changed = true
	if not ProjectSettings.has_setting(GLOBAL_VAR_BIT_DEPTH):
		ProjectSettings.set_setting(GLOBAL_VAR_BIT_DEPTH, {
			"type": "int",
			"value": 5
		})
		any_setting_changed = true
	if not ProjectSettings.has_setting(GLOBAL_VAR_FOG_COLOR):
		ProjectSettings.set_setting(GLOBAL_VAR_FOG_COLOR, {
			"type": "color",
			"value": Color(0.5, 0.5, 0.5, 0.0)
		})
		any_setting_changed = true
	if not ProjectSettings.has_setting(GLOBAL_VAR_FOG_FAR):
		ProjectSettings.set_setting(GLOBAL_VAR_FOG_FAR, {
			"type": "float",
			"value": 20.0
		})
		any_setting_changed = true
	if not ProjectSettings.has_setting(GLOBAL_VAR_FOG_NEAR):
		ProjectSettings.set_setting(GLOBAL_VAR_FOG_NEAR, {
			"type": "float",
			"value": 10.0
		})
		any_setting_changed = true
	if not ProjectSettings.has_setting(GLOBAL_VAR_SNAP):
		ProjectSettings.set_setting(GLOBAL_VAR_SNAP, {
			"type": "float",
			"value": 0.025
		})
		any_setting_changed = true

	if any_setting_changed:
		ProjectSettings.save()

func _disable_plugin() -> void:
	remove_autoload_singleton(AUTOLOAD_NAME)
