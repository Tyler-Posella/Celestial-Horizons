extends Resource
class_name Item
# Exports
@export var name : String = "None"
@export var texture : Texture
@export var description : String = "None"

# Functions
func setName(new_name : String):
	name = new_name
	
	
func getName():
	return name
	
	
func setTexture(new_texture : Texture):
	texture = new_texture
	
	
func getTexture():
	return texture
	

func setDescription(new_description : String):
	description = new_description
	

func getDescription():
	return description
