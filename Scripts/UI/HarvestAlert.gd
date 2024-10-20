class_name HarvestAlert
extends Control

# Export Variables
@export var item : ItemRes

# Onready Variables
@onready var texture = $TextureRect

# Functions
func _ready():
	texture.texture = item.get_texture()
	
