extends Node2D
class_name GridObject

func _ready() -> void:
	pass
	
	
func configure_position(layer : InteractiveTilemapLayer):
	global_position = layer.get_tile_center_position(layer.get_tile_coordinates(self))
