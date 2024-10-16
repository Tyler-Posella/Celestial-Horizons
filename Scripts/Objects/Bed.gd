class_name Bed
extends Node2D

# Constnats
const CONFIRMATION_MENU = preload("res://Scenes/UI/GamePrompts/ConfirmationMenu.tscn")

# Signals
signal slept()

# Functions
func _ready():
	self.slept.connect(Game.get_date_time()._on_day_finished)
	
	
func _on_interactable_component_interacted() -> void:
		# Handle sleeping mechanic
	var new_confirmation_menu = CONFIRMATION_MENU.instantiate()
	var prompt : String = "Are you sure you would like to sleep?"
	new_confirmation_menu.confirmed.connect(_on_sleep_confirmed)
	new_confirmation_menu.declined.connect(_on_sleep_declined)
	Game.get_ui_node().add_child(new_confirmation_menu)
	new_confirmation_menu.set_prompt(prompt)


func _on_sleep_confirmed():
	slept.emit()
	

func _on_sleep_declined():
	pass
