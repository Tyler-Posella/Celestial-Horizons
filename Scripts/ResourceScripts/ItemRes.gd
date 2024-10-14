class_name ItemRes
extends Resource

# Exports
@export var name : String = "None"
@export var texture : AtlasTexture = null
@export var description : String = "None"
@export var sell_price : int

# Functions
func get_item_name():
	return name

	
func get_texture():
	return texture
	

func get_description():
	return description
	

func get_sell_price():
	return sell_price
