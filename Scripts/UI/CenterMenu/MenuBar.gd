extends HBoxContainer

# Variables
@onready var selected_button : TopBarButton
@onready var old_button : TopBarButton
var button_array = []

# Functions
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
	const exit_scene = preload("res://Scenes/UI/CenterMenu/ExitMenu.tscn")
	var new_scene = exit_scene.instantiate()
	get_parent().setMenuScene(new_scene)
	buttonPress($ExitButton)


func _on_options_button_pressed() -> void:
	const options_scene = preload("res://Scenes/UI/CenterMenu/OptionsMenu.tscn")
	var new_scene = options_scene.instantiate()
	get_parent().setMenuScene(new_scene)
	buttonPress($OptionsButton)


func _on_quests_button_pressed() -> void:
	const quests_scene = preload("res://Scenes/UI/CenterMenu/QuestsMenu.tscn")
	var new_scene = quests_scene.instantiate()
	get_parent().setMenuScene(new_scene)
	buttonPress($QuestsButton)


func _on_relations_button_pressed() -> void:
	const relations_scene = preload("res://Scenes/UI/CenterMenu/RelationsMenu.tscn")
	var new_scene = relations_scene.instantiate()
	get_parent().setMenuScene(new_scene)
	buttonPress($RelationsButton)


func _on_player_info_button_pressed() -> void:
	const player_info_scene = preload("res://Scenes/UI/CenterMenu/PlayerInfoMenu.tscn")
	var new_scene = player_info_scene.instantiate()
	get_parent().setMenuScene(new_scene)
	buttonPress($PlayerInfoButton)


func _on_crafting_button_pressed() -> void:
	const crafting_scene = preload("res://Scenes/UI/CenterMenu/CraftingMenu.tscn")
	var new_scene = crafting_scene.instantiate()
	get_parent().setMenuScene(new_scene)
	buttonPress($CraftingButton)


func _on_inventory_button_pressed() -> void:
	const inventory_scene = preload("res://Scenes/UI/CenterMenu/InventoryMenu.tscn")
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
	
