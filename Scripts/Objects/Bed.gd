class_name Bed
extends Node2D

# Constnats
const CONFIRMATION_MENU = preload("res://Scenes/UI/GamePrompts/ConfirmationMenu.tscn")

# Functions	
func _on_interactable_component_interacted() -> void:
	# Handle sleeping mechanic
	var new_confirmation_menu = CONFIRMATION_MENU.instantiate()
	var prompt : String = "Are you sure you would like to sleep?"
	new_confirmation_menu.confirmed.connect(_on_sleep_confirmed)
	new_confirmation_menu.declined.connect(_on_sleep_declined)
	Game.get_ui_node().add_child(new_confirmation_menu)
	new_confirmation_menu.set_prompt(prompt)


func _on_sleep_confirmed():
	SignalManager.emit_signal_global("advance_day", [])

func _on_sleep_declined():
	pass
