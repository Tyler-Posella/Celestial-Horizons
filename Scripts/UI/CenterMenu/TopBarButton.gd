extends TextureButton
class_name TopBarButton
# Export variables
@export var default_texture : Texture
@export var default_pressed_texture : Texture
@export var normal_texture : Texture
@export var selected_texture : Texture
@export var hover_texture : Texture
@export var disabled_texture : Texture
@export var focused_texture : Texture

#Instance variables
var is_selected : bool = false

# Functions
func _ready():
	if(normal_texture != null):
		texture_normal = normal_texture
	else:
		texture_normal = default_texture
	if(selected_texture != null):
		texture_pressed = selected_texture
	else:
		texture_pressed = default_pressed_texture
	texture_focused = selected_texture
	texture_hover = hover_texture
	texture_disabled = disabled_texture
	texture_focused = focused_texture
	
	
func _on_pressed() -> void:
	is_selected = true
	
	
func press():
	if(button_pressed == true):
		pass
	else:
		button_pressed = true
	
		
func unpress():
	if(button_pressed == false):
		pass
	else:
		button_pressed = false
		
