class_name Fruit
extends Item

# Exports
@export var growth_time : int
@export var decay_time : int
@export var sell_price : int
@export var noureshment : int
@export var grown_texture : Texture

# Functions
func get_grown_texture():
	return grown_texture
