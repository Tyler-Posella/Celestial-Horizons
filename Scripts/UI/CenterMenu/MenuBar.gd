extends HBoxContainer

# Constants
var top_button_scene = preload("res://Scenes/UI/GameUI/CenterMenu/TopBarButton.tscn")
# Variables
@onready var selected_button : TopBarButton
@onready var old_button : TopBarButton
var buttons = []
var current_button : TopBarButton
var current_menu
# Signals
signal updateMenu(new_menu)
# Functions
func _ready():
	for i in 7:
		var button = top_button_scene.instantiate()
		button.buttonpress.connect(_on_button_press)
		buttons.append(button)
		add_child(button)
	
	buttons[6].setScenePath("res://Scenes/UI/CenterMenu/ExitMenu.tscn")
	buttons[5].setScenePath("res://Scenes/UI/CenterMenu/OptionsMenu.tscn")
	buttons[4].setScenePath("res://Scenes/UI/CenterMenu/QuestsMenu.tscn")
	buttons[3].setScenePath("res://Scenes/UI/CenterMenu/RelationsMenu.tscn")
	buttons[2].setScenePath("res://Scenes/UI/CenterMenu/PlayerInfoMenu.tscn")
	buttons[1].setScenePath("res://Scenes/UI/CenterMenu/CraftingMenu.tscn")
	buttons[0].setScenePath("res://Scenes/UI/CenterMenu/InventoryMenu.tscn")



func _on_button_press(new_button : TopBarButton):
	if(current_button == null):
		new_button.press()
		current_button = new_button
		var new_scene_path = new_button.getScenePath()
		var new_scene = load(new_scene_path)
		var new_menu = new_scene.instantiate()
		updateMenu.emit(new_menu)
		current_button = new_button
	else:
		new_button.press()
		current_button.unpress()
		var new_scene_path = new_button.getScenePath()
		var new_scene = load(new_scene_path)
		var new_menu = new_scene.instantiate()
		current_button = new_button
		updateMenu.emit(new_menu)
		
		
	
