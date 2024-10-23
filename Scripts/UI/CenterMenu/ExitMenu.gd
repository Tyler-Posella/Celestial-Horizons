class_name ExitMenu
extends Control

# Constants
const CONFIRMATION_MENU_SCENE = preload("res://Scenes/UI/GamePrompts/ConfirmationMenu.tscn")

# Functions
func _on_save_button_pressed() -> void:
	var new_confirmation_menu = CONFIRMATION_MENU_SCENE.instantiate()
	var prompt : String = "Are you sure you would like to save and override the existing save file?"
	new_confirmation_menu.confirmed.connect(_on_save_confirm)
	Game.get_ui_node().add_child(new_confirmation_menu)
	new_confirmation_menu.set_prompt(prompt)
	
	
func _on_save_confirm():
	SaveHandler.save_game()
	
	
func _on_exit_button_pressed() -> void:
	var new_confirmation_menu = CONFIRMATION_MENU_SCENE.instantiate()
	var prompt : String = "Are you sure you would like to leave the game? Any unsaved progress will be lost!"
	new_confirmation_menu.confirmed.connect(_on_exit_confirm)
	Game.get_ui_node().add_child(new_confirmation_menu)
	new_confirmation_menu.set_prompt(prompt)
	
	
func _on_exit_confirm():
	GameManager.return_to_menu()
