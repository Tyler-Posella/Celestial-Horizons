class_name InteractiveTilemapLayer
extends TileMapLayer

# Functions
func get_tile_coordinates(object):
	# Get the global position of the object
	var global_pos = object.global_position
	
	# Convert global position to local tilemap position
	var local_pos = self.to_local(global_pos)
	
	# Convert local position to tile coordinates
	var tile_coords = self.local_to_map(local_pos)
	
	return tile_coords


func get_tile_center_position(tile_coords):
	# Get the local position of the top-left corner of the tile
	var tile_position = self.map_to_local(tile_coords)
	
	# Get the tile size (the size of each cell in the tilemap)
	var tile_size = 16
	
	# Calculate the center of the tile by adding half the tile size to the top-left position
	var center_position = Vector2(tile_position.x, tile_position.y)
	
	return center_position


func _on_child_entered_tree(node: Node) -> void:
	if(node is GridObject):
		print("as")
		node.position = get_tile_center_position(get_tile_coordinates(node))
