extends Node2D

# Functions
func _ready():
	pass

func save():
	var save_dict = {
		"filename" : get_scene_file_path(),
		"save_file_path" : "/Users/tylerposella/Desktop/Nekowind-Adventures/LocalData/StartLevel.json",
		"pos_x" : position.x,
		"pos_y" : position.y
	}
	return save_dict
