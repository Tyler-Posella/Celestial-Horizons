class_name WelcomeGamePrompt
extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_close_prompt_button_pressed() -> void:
	Game.get_player().set_player_name($PanelContainer/NinePatchRect/VBoxContainer/NameEntry.text)
	self.queue_free()
