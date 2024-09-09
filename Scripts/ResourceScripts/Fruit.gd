extends Item
class_name Fruit
# Exports
@export var growth_time : int
@export var decay_time : int
@export var sell_price : int
@export var noureshment : int
@export var grown_texture : Texture

# Functions
func getGrownTexture():
	return grown_texture
