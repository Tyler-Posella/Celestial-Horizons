class_name CraftingItemIngredient
extends Control


# Called when the node enters the scene tree for the first time.
func set_texture(new_tex : Texture):
	$Control.texture = new_tex


func set_count(new_count : int):
	$Label.text = str(new_count)
