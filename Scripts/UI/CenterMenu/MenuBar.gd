extends HBoxContainer

# Constants
var top_button_scene = preload("res://Scenes/UI/GameUI/CenterMenu/TopBarButton.tscn")
# Variables
@onready var selected_button : GuiMenuButton
@onready var old_button : GuiMenuButton
var buttons = []
var current_button : GuiMenuButton
var current_menu
# Signals
signal updateMenu(new_menu)
# Functions
func _ready():
	for i in 7:
		var button = top_button_scene.instantiate()
		button.buttonpress.connect(_on_button_press)
		buttons.append(button)
		add_child(buttons[i])
	
	buttons[6].setResource(load("res://Resoures/UI/GameMenu/Exit.tres"))
	buttons[5].setResource(load("res://Resoures/UI/GameMenu/Options.tres"))
	buttons[4].setResource(load("res://Resoures/UI/GameMenu/Quests.tres"))
	buttons[3].setResource(load("res://Resoures/UI/GameMenu/Relations.tres"))
	buttons[2].setResource(load("res://Resoures/UI/GameMenu/PlayerInfo.tres"))
	buttons[1].setResource(load("res://Resoures/UI/GameMenu/Crafting.tres"))
	buttons[0].setResource(load("res://Resoures/UI/GameMenu/Inventory.tres"))
	
	for i in buttons.size():
		buttons[i].setTexture()


func _on_button_press(new_button : GuiMenuButton):
	if(current_button == null):
		new_button.press()
		current_button = new_button
		var new_scene = current_button.getScene()
		var new_menu = new_scene.instantiate()
		updateMenu.emit(new_menu)
	else:
		new_button.press()
		current_button.unpress()
		var new_scene = new_button.getScene()
		var new_menu = new_scene.instantiate()
		current_button = new_button
		updateMenu.emit(new_menu)
		
		
	
