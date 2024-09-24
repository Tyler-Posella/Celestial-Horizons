extends HBoxContainer

# Signals
signal menu_updated(new_menu)

# Constants
const TOP_BUTTON_SCENE = preload("res://Scenes/UI/GameUI/CenterMenu/TopBarButton.tscn")

# Variables
var buttons = []
var current_button : GuiMenuButton
var current_menu

# Onready Variables
@onready var selected_button : GuiMenuButton
@onready var old_button : GuiMenuButton

# Functions
func _ready():
	for i in 7:
		var button = TOP_BUTTON_SCENE.instantiate()
		button.buttonpress.connect(_on_button_press)
		buttons.append(button)
		add_child(buttons[i])
	
	buttons[6].set_resource(load("res://Resoures/UI/GameMenu/Exit.tres"))
	buttons[5].set_resource(load("res://Resoures/UI/GameMenu/Options.tres"))
	buttons[4].set_resource(load("res://Resoures/UI/GameMenu/Quests.tres"))
	buttons[3].set_resource(load("res://Resoures/UI/GameMenu/Relations.tres"))
	buttons[2].set_resource(load("res://Resoures/UI/GameMenu/PlayerInfo.tres"))
	buttons[1].set_resource(load("res://Resoures/UI/GameMenu/Crafting.tres"))
	buttons[0].set_resource(load("res://Resoures/UI/GameMenu/Inventory.tres"))
	
	for i in buttons.size():
		buttons[i].set_texture()


func _on_button_press(new_button : GuiMenuButton):
	if(current_button == null):
		new_button.press()
		current_button = new_button
		var new_scene = current_button.get_scene()
		var new_menu = new_scene.instantiate()
		menu_updated.emit(new_menu)
	else:
		new_button.press()
		current_button.unpress()
		var new_scene = new_button.get_scene()
		var new_menu = new_scene.instantiate()
		current_button = new_button
		menu_updated.emit(new_menu)
		
