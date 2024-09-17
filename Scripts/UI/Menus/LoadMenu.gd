extends Control

const save_box_scene = preload("res://Scenes/UI/Menus/MainMenu/SaveHBox.tscn")

func _ready():
	for i in 3:
		var save_box = save_box_scene.instantiate()
		$VBoxContainer.add_child(save_box)
