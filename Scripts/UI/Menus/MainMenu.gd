class_name MainMenu
extends Control

#Constants
const MUSIC = preload("res://Audio/Music/Menu.wav")
const SAVE_MANAGER_MENU = preload("res://Scenes/UI/Menus/MainMenu/SaveManagerMenu.tscn")

#Functions
func _ready():
	Game.set_ui(self)


func _on_start_button_pressed() -> void:
	GameManager.start_new_game()
	

func _on_load_button_pressed() -> void:
	var new_save_menu = SAVE_MANAGER_MENU.instantiate()
	var new_ui = new_save_menu
	Game.get_ui_node().add_child(new_ui)
	self.queue_free()
	

func _on_options_button_pressed() -> void:
	pass # Replace with function body.


func _on_quit_button_pressed() -> void:
	get_tree().quit()
