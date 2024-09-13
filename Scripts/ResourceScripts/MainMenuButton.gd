extends Resource
class_name UiMenuButton
# Exports
@export var scene : PackedScene
@export var normal_texture : AtlasTexture
@export var pressed_texture : AtlasTexture
@export var hovered_texture : AtlasTexture
@export var disabled_texture : AtlasTexture
@export var focused_texture : AtlasTexture

# Functions
func getNormalTexture():
	return normal_texture
	
	
func getPressedTexture():
	return pressed_texture
	
	
func getHoveredTexture():
	return hovered_texture
	
	
func getDisabledTexture():
	return disabled_texture
	
	
func getFocusedTexture():
	return focused_texture
	

func getScene():
	return scene
