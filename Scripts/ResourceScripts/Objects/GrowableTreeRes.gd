class_name GrowableTreeRes
extends TreeRes

# Export Variables
@export var fruit_grown_texture : Texture
@export var fruit : FruitRes

# Functions
func get_fruity_texture():
	return fruit_grown_texture
	

func get_growtime():
	return growtime
	
	
func get_fruit():
	return fruit
