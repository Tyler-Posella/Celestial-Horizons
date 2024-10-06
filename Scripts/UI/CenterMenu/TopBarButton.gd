class_name GuiMenuButton
extends TextureButton

# Signals
signal buttonpress(button : GuiMenuButton)

# Export variables
@export var default_texture : Texture
@export var default_pressed_texture : Texture

# Variables
var scene : PackedScene
var resource : UiMenuButtonRes

# Functions
func _ready():
	texture_normal = default_texture
	texture_pressed = default_pressed_texture


func _on_press() -> void:
	buttonpress.emit(self)
	
	
func set_resource(new_resource : UiMenuButtonRes):
	resource = new_resource
	scene = resource.scene
	
func set_texture():
	if(resource.get_normal_texture() != null):
		texture_normal = resource.get_normal_texture()
	if(resource.get_pressed_texture() != null):
		texture_pressed = resource.get_pressed_texture()
	
	
func get_scene():
	return scene
	
	
func press():
	button_pressed = true
	
	
func unpress():
	button_pressed = false
	
	
	

	
