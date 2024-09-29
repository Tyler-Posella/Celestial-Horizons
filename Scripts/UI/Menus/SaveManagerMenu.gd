class_name SaveManagerMenu
extends Control

# Constants
const save_instance_scene = preload("res://Scenes/UI/Menus/MainMenu/SaveInstance.tscn")

# Variables
var save_list : Array[SaveInstance]
var selected_save : SaveInstance

# Functions
func _ready():
	Utils.set_ui(self)
	print("Attempting to access local save data.")

	var save_paths = [
		"res://LocalData/Saves/SaveFile1",
		"res://LocalData/Saves/SaveFile2",
		"res://LocalData/Saves/SaveFile3"
	]
	var dir = DirAccess.open("res://LocalData/Saves")
	for save_path in save_paths:
		if dir.dir_exists(save_path):
			print(save_path + " exists.")
			dir.change_dir(save_path)
			if(dir.file_exists("PlayerData.json")):
				print("Has PlayerData")
		else:
			dir.make_dir(save_path)
			print(save_path + " does not exist. Creating directory.")
			
	for i in 3:
		var save_instance : SaveInstance = save_instance_scene.instantiate()
		save_list.append(save_instance)
		save_instance.clicked.connect(_on_save_click)
		save_instance.save_dir = save_paths[i]
		save_instance.save_number = i
		$VBoxContainer/SaveContainer/VBoxContainer.add_child(save_instance, true)
		

func _on_save_click(clicked_save : SaveInstance):
	clicked_save.select()
	if(selected_save != null):
		selected_save.deselect()
	selected_save = clicked_save
	var selected_save_dir = DirAccess.open(clicked_save.save_dir)
	if(selected_save_dir.file_exists("PlayerData.json")):
		# Handle load game
		pass
	else:
		# Handle new game
		pass

func _on_play_button_pressed() -> void:
	if(selected_save != null):
		var selected_save_dir = DirAccess.open(selected_save.save_dir)
		if(selected_save_dir.file_exists("PlayerData.json")):
			SaveManager.set_current_save(selected_save.save_dir)
			GameManager.start_loaded_game(selected_save.save_dir)
		else:
			SaveManager.set_current_save(selected_save.save_dir)
			GameManager.start_new_game()
			pass


func _on_info_button_pressed() -> void:
	pass # Replace with function body.


func _on_delete_button_pressed():
	delete_directory(selected_save.save_dir)	
	selected_save.deselect()
	selected_save = null
	
	
func delete_directory(save_directory: String):
	var dir = DirAccess.open(save_directory)
	dir.list_dir_begin()  # Start listing files
	var file_name = dir.get_next()

	while file_name != "":
	# Ignore "." and ".." which represent current and parent directories
		if file_name != "." and file_name != "..":
			var file_path = save_directory + "/" + file_name
			if not dir.current_is_dir():  # Check if it's a file
				var error = dir.remove(file_path)
				if error != OK:
					print("Failed to delete file: ", file_path)
				else:
					print("Deleted file: ", file_path)
		file_name = dir.get_next()  # Get the next file/directory

	dir.list_dir_end()  # End the directory listing
	print("All files deleted in directory: ", save_directory)
	


func _on_return_button_pressed() -> void:
	pass # Replace with function body.
