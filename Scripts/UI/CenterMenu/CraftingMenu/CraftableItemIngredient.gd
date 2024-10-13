class_name CraftableItemIngredient
extends Control

var item : ItemRes

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$TextureRect.texture = item.texture


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
