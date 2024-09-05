extends Item
class_name Fruit

@export var growth_time : int
@export var decay_time : int
@export var sell_price : int
@export var noureshment : int
@export var grown_texture : Texture

func getGrownTexture():
	return grown_texture
