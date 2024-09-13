extends TextureButton
class_name GuiMenuButton
# Export variables
@export var default_texture : Texture
@export var default_pressed_texture : Texture
# Instance variables
var scene : PackedScene
var resource : UiMenuButton
# Signals
signal buttonpress(button : GuiMenuButton)

# Functions
func _ready():
	texture_normal = default_texture
	texture_pressed = default_pressed_texture


func _on_press() -> void:
	buttonpress.emit(self)
	
	
func setResource(new_resource : UiMenuButton):
	resource = new_resource
	scene = resource.scene
	
func setTexture():
	if(resource.getNormalTexture() != null):
		texture_normal = resource.getNormalTexture()
	if(resource.getPressedTexture() != null):
		texture_pressed = resource.getPressedTexture()
	
	
func getScene():
	return scene
	
	
func press():
	button_pressed = true
	
	
func unpress():
	button_pressed = false
	
	
	

	
