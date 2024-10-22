extends Node2D

# Export Variables
@export var tile_size: Vector2 = Vector2(16, 16)  # Adjust based on your tile size

# Onready Variables
var tile_map_layers = []

# Functions
func _ready() -> void:
	var tile_map_children = $TileMap.get_children()
	for child in tile_map_children:
		tile_map_layers.append(child)
	SignalManager.add_listener("player_hoed", self, "_on_player_hoe")
	SignalManager.add_listener("player_watered", self, "_on_player_water")
		
			
func _on_player_hoe():
	# Get the global position of the mouse
	var mouse_position = get_global_mouse_position()
	# Convert the mouse position to the local position within the TileMapLayer (if needed)
	var local_mouse_position = self.to_local(mouse_position)
	# Calculate the cell position by dividing the local mouse position by the tile size
	var cell_x = floor(mouse_position.x / tile_size.x)
	var cell_y = floor(mouse_position.y / tile_size.y)
	var cell_position = Vector2(cell_x, cell_y)
	
	var is_good : bool = true
	var i : int = tile_map_layers.size() - 1
	while(is_good):
		print(i)
		var tile_data = tile_map_layers[i].get_cell_tile_data(cell_position)
		if(tile_data != null):
			if(tile_data.get_custom_data("Hoe-able") == false):
				is_good = false
				print(tile_data)
				print(tile_data.get_custom_data("Hoe-able"))
				break
			else:
				print(tile_data)
				print(tile_data.get_custom_data("Hoe-able"))
				tile_map_layers[i].set_cell(cell_position, 23, Vector2i(-1, -1))
		if(i == 0):
			is_good = false
			break
		else:
			i = i - 1

func _on_player_water():
	# Get the global position of the mouse
	var mouse_position = get_global_mouse_position()
	# Convert the mouse position to the local position within the TileMapLayer (if needed)
	var local_mouse_position = self.to_local(mouse_position)
	# Calculate the cell position by dividing the local mouse position by the tile size
	var cell_x = floor(mouse_position.x / tile_size.x)
	var cell_y = floor(mouse_position.y / tile_size.y)
	var cell_position = Vector2(cell_x, cell_y)
	
	var is_good : bool = true
	var i : int = tile_map_layers.size() - 1
	while(is_good):
		print(i)
		var tile_data = tile_map_layers[i].get_cell_tile_data(cell_position)
		if(tile_data != null):
			if(tile_data.get_custom_data("Water-able") == false):
				is_good = false
				break
			else:
				print(tile_data)
				print(tile_data.get_custom_data("Water-able"))
				tile_map_layers[i].set_cell(cell_position, 26, Vector2i(1,1))
		if(i == 0):
			is_good = false
			break
		else:
			i = i - 1
			


func save():
	var save_dict = {
		"filename" : get_scene_file_path(),
		"save_file_path" : "/Users/tylerposella/Desktop/Nekowind-Adventures/LocalData/StartLevel.json",
		"pos_x" : position.x,
		"pos_y" : position.y
	}
	return save_dict
