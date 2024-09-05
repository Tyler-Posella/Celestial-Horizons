extends Control

@export var inventory_slot : InventorySlot

@export var selected_texture : Texture
@export var unselected_texture : Texture
@onready var sprite = $NinePatchRect/ItemSprite
@onready var text_edit = $NinePatchRect/CountText
func _ready():
	$NinePatchRect.texture = unselected_texture
	updateSlot()
	
func updateSlot():
	if(inventory_slot.count == 0):
		sprite.texture = null
		text_edit.text = str(0)
	if(inventory_slot.getItem() != null):
		sprite.texture = inventory_slot.getItem().texture
		text_edit.text = str(inventory_slot.getCount())
		
func updateSelection():
	if(inventory_slot.is_selected):
		$NinePatchRect.texture = selected_texture
	if(inventory_slot.is_selected == false):
		$NinePatchRect.texture = unselected_texture
