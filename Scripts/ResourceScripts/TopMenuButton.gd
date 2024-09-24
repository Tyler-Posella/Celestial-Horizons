class_name UiMenuButton
extends Resource

# Exports
@export var scene : PackedScene
@export var normal_texture : AtlasTexture
@export var pressed_texture : AtlasTexture
@export var hovered_texture : AtlasTexture
@export var disabled_texture : AtlasTexture
@export var focused_texture : AtlasTexture


# Functions
func get_normal_texture():
	return normal_texture
	
	
func get_pressed_texture():
	return pressed_texture
	
	
func get_hovered_texture():
	return hovered_texture
	
	
func get_disabled_texture():
	return disabled_texture
	
	
func get_focused_texture():
	return focused_texture
	

func get_scene():
	return scene
