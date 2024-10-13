class_name CraftableItem
extends Control

# Signals

# Constnats
const CRAFTING_TOOLTIP_SCENE = preload("res://Scenes/UI/CenterMenu/CraftingMenu/CraftableItemHover.tscn")
# Variables
var item : ItemRes
var item_hover_tooltip : CraftableItemHover

# Onready Variables
@onready var item_texture = $MarginContainer/AspectRatioContainer/TextureRect

# Functions
func _ready():
	if(item != null):
		item_texture.texture = item.get_texture()
	

func set_item(new_item : ItemRes):
	item = new_item


func _on_texture_rect_mouse_entered() -> void:
	print("Mouse Entered")
	item_hover_tooltip = CRAFTING_TOOLTIP_SCENE.instantiate()
	$MarginContainer/AspectRatioContainer/TextureRect.add_child(item_hover_tooltip)


func _on_texture_rect_mouse_exited() -> void:
	print("Mouse Exited")
	item_hover_tooltip.queue_free()
