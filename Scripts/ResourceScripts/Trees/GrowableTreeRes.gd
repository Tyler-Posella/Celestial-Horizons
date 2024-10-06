class_name GrowableTreeRes
extends TreeRes

# Export Variables
@export var fruit_grown_texture : Texture
@export var grow_time : int
@export var fruit : FruitRes

# Functions
func get_fruity_texture():
	return fruit_grown_texture
	

func get_grow_time():
	return grow_time
	
	
func get_fruit():
	return fruit
