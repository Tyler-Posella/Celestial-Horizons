class_name TreeRes
extends Resource

# Export Variables
@export var normal_texture : Texture
@export var fall_texture : Texture
@export var hitpoints : int = 5

# Functions
func get_default_texture():
	return normal_texture
	
	
func get_fall_texture():
	return fall_texture
	
	
func get_hitpoints():
	return hitpoints
