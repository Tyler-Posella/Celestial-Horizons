extends GridContainer

# Constants
const ui_slot_scene = preload("res://Scenes/UI/GameUI/Inventory/InventorySlotUI.tscn")

# Variables
var hotbar_slots = []

# Functions
func _ready():
	var player = Utils.getPlayer()
	for i in 10:
		var slot = ui_slot_scene.instantiate()
		player.getInventoryComponent().getSlot(i,0).updateUI.connect(_on_ui_slot_update)
		slot.inventory_slot = player.getInventoryComponent().getSlot(i, 0)
		hotbar_slots.append(slot)
		add_child(slot)
		
		
func _on_ui_slot_update(x_num : int, y_num : int):
	hotbar_slots[x_num].updateSlot()
	hotbar_slots[x_num].updateSelection()
