class_name SaveManagerMenu
extends Control

# Constants
const SAVE_INSTANCE = preload("res://Scenes/UI/Menus/MainMenu/SaveInstance.tscn")

# Variables
var selected_save : SaveInstance
var saves = []

# Functions
func _ready():
	Game.set_ui(self)
	print("Attempting to access local save data.")
	
	# Get a list of all the current save files
	var directories = []
	var dir = DirAccess.open("res://LocalData/Saves/")
	dir.list_dir_begin()
	var file_name = dir.get_next()
	while file_name != "":
		if dir.current_is_dir() and file_name != "." and file_name != "..":
			directories.append(file_name)
		file_name = dir.get_next()
	dir.list_dir_end()
	
	# Load all of the existing save data and create a save instance, if any exist
	for i in directories.size():
		dir = DirAccess.open("res://LocalData/Saves/" + directories[i])
		var new_save = SAVE_INSTANCE.instantiate()
		new_save.set_save("res://LocalData/Saves/" + directories[i])
		new_save.selected.connect(_on_save_selected)
		new_save.deselected.connect(_on_save_deselected)
		new_save.save_number = i
		saves.append(new_save)
		$PanelContainer/SaveContainer/VBoxContainer.add_child(new_save)
	

func _on_save_selected(clicked_save : SaveInstance):
	if(selected_save != null):
		selected_save.deselect()
	selected_save = clicked_save
	var selected_save_dir = DirAccess.open(selected_save.save_dir)
	if(selected_save_dir.file_exists("PlayerData.json")):
		# Handle load game
		pass
	else:
		# Handle new game
		pass


func _on_save_deselected(clicked_save : SaveInstance):
	selected_save = null
	
	
func _on_play_button_pressed() -> void:
	if(selected_save != null):
		GameManager.start_loaded_game(selected_save)


func _on_info_button_pressed() -> void:
	if(selected_save != null):
		pass


func _on_delete_button_pressed():
	if(selected_save != null):
		SaveManager.delete_save(selected_save.save_dir)
		selected_save.queue_free()
		saves.erase(selected_save)
		for i in saves.size():
			saves[i].set_number(i+1)
			
	
	
func _on_return_button_pressed() -> void:
	var main_menu_scene = load("res://Scenes/UI/Menus/MainMenu/MainMenu.tscn")
	var new_menu = main_menu_scene.instantiate()
	Game.get_ui_node().add_child(new_menu)
	self.queue_free()
	
	
