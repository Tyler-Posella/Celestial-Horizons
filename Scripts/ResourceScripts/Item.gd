class_name Item
extends Resource

# Exports
@export var name : String = "None"
@export var texture : Texture
@export var description : String = "None"

# Functions
func set_item_name(new_name : String):
	name = new_name
	
	
func get_item_name():
	return name
	
	
func set_texture(new_texture : Texture):
	texture = new_texture
	
	
func get_texture():
	return texture
	

func set_description(new_description : String):
	description = new_description
	

func get_description():
	return description
