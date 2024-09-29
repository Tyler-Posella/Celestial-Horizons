class_name SaveManagerMenu
extends Control

const save_instance_scene = preload("res://Scenes/UI/Menus/MainMenu/SaveInstance.tscn")

func _ready():
	print("Attempting to access local save data.")
	var dir = DirAccess.open("res://LocalData/Saves")
	var save_paths = [
		"res://LocalData/Saves/SaveFile1",
		"res://LocalData/Saves/SaveFile2",
		"res://LocalData/Saves/SaveFile3"
	]
	for i in 3:
		var save_instance = save_instance_scene.instantiate()
		save_instance.save_dir = save_paths[i]
		save_instance.save_number = i
		$PanelContainer/VBoxContainer.add_child(save_instance)
	for save_path in save_paths:
		if dir.dir_exists(save_path):
			print(save_path + " exists.")
			dir.change_dir(save_path)
			if(dir.file_exists("PlayerData.json")):
				print("Has PlayerData")
		else:
			dir.make_dir(save_path)
			print(save_path + " does not exist. Creating directory.")
			
