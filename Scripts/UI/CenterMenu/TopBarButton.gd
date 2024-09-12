extends TextureButton
class_name GuiMenuButton
# Export variables
@export var default_texture : Texture
@export var default_pressed_texture : Texture
@export var normal_texture : Texture
@export var selected_texture : Texture
@export var hover_texture : Texture
# Instance variables
var scene_path : String
# Signals
signal buttonpress(button : GuiMenuButton)

# Functions
func _ready():
	texture_normal = default_texture
	texture_pressed = default_pressed_texture


func _on_press() -> void:
	buttonpress.emit(self)
	
	
func setScenePath(path : String):
	scene_path = path
	
	
func getScenePath():
	return scene_path
	
func press():
	button_pressed = true
	
	
func unpress():
	button_pressed = false
	
	
	

	
