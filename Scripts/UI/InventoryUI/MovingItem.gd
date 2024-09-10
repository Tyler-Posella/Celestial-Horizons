extends Control
var count : int
var item : Item

func setObject(inventory_slot: InventorySlot):
	item = inventory_slot.getItem()
	count = inventory_slot.getCount()
	$PanelContainer/TextureRect.texture = inventory_slot.getItem().getTexture()
	$PanelContainer/Count.text = str(inventory_slot.getCount())


func _process(delta: float) -> void:
	self.global_position = get_viewport().get_mouse_position()
