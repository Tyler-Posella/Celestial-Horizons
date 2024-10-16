class_name ConfirmationMenu
extends Control

# Signals
signal confirmed()
signal declined()

# Onready Variables
@onready var prompt_label = $PanelContainer/NinePatchRect/VBoxContainer/PromptLabel

# Functions
func set_prompt(new_prompt : String):
	prompt_label.set_text(new_prompt)


func _on_confirm_button_pressed() -> void:
	confirmed.emit()
	queue_free()

func _on_decline_button_pressed() -> void:
	declined.emit()
	queue_free()
