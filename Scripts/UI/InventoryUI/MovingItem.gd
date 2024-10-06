class_name MovingInvItem
extends Control

# Variables
var count : int
var item : ItemRes

func set_object(inventory_slot: InventorySlot):
	item = inventory_slot.get_item()
	count = inventory_slot.get_count()
	$PanelContainer/TextureRect.texture = inventory_slot.get_item().get_texture()
	$PanelContainer/Count.text = str(inventory_slot.get_count())


func _process(delta: float) -> void:
	self.global_position = get_viewport().get_mouse_position()
