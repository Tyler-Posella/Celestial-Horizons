extends Resource
class_name Item

@export var name : String = "None"
@export var texture : Texture

func setName(nm : String):
	name = nm
	
func getName():
	return name
	
func setTexture(txt : Texture):
	texture = txt
	
func getTexture():
	return texture
