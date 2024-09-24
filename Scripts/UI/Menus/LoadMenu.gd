extends Control

const SAVE_BOX_SCENE = preload("res://Scenes/UI/Menus/MainMenu/SaveHBox.tscn")

func _ready():
	for i in 3:
		var save_box = SAVE_BOX_SCENE.instantiate()
		$VBoxContainer.add_child(save_box)
