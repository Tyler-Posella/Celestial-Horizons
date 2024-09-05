extends HBoxContainer

@onready var selected_button : TopBarButton
@onready var old_button : TopBarButton
@onready var button_array = []

func _ready():
	button_array.append($InventoryButton)
	button_array.append($CraftingButton)
	button_array.append($PlayerInfoButton)
	button_array.append($RelationsButton)
	button_array.append($QuestsButton)
	button_array.append($OptionsButton)
	button_array.append($ExitButton)
	$InventoryButton.press()


func _on_exit_button_pressed() -> void:
	GameManager.returnToMenu()

func _on_options_button_pressed() -> void:
	const options_scene = preload("res://Scenes/UI/OptionsMenu.tscn")
	var new_scene = options_scene.instantiate()
	get_parent().setMenuScene(new_scene)
	buttonPress($OptionsButton)

func _on_quests_button_pressed() -> void:
	buttonPress($QuestsButton)

func _on_relations_button_pressed() -> void:
	buttonPress($RelationsButton)

func _on_player_info_button_pressed() -> void:
	buttonPress($PlayerInfoButton)

func _on_crafting_button_pressed() -> void:
	buttonPress($CraftingButton)

func _on_inventory_button_pressed() -> void:
	const inventory_scene = preload("res://Scenes/UI/InventoryMenu.tscn")
	var new_scene = inventory_scene.instantiate()
	get_parent().setMenuScene(new_scene)
	buttonPress($InventoryButton)
	
func buttonPress(button):
	button.press()
	for i in button_array.size():
		if(button == button_array[i]):
			pass
		else:
			button_array[i].unpress()
	
