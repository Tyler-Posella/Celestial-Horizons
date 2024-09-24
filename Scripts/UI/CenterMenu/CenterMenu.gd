class_name CenterMenu
extends VBoxContainer

# Variables
var current_menu
var moving_item

# Functions
func _ready():
		$MenuBar.buttons[0].pressed.emit()
	
	
func set_menu(new_menu):
	if(current_menu != null):
		current_menu.queue_free()
		$MenuRect.add_child(new_menu)
		current_menu = new_menu
	else:
		$MenuRect.add_child(new_menu)
		current_menu = new_menu
	

func _on_menu_bar_menu_updated(new_menu: Variant) -> void:
	set_menu(new_menu)
