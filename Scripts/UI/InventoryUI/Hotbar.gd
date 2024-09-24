extends GridContainer

# Constants
const UI_SLOT_SCENE = preload("res://Scenes/UI/GameUI/Inventory/InventorySlotUI.tscn")

# Variables
var hotbar_slots = []

# Functions
func _ready():
	var player = Utils.get_player()
	for i in 10:
		var slot = UI_SLOT_SCENE.instantiate()
		player.get_inventory_component().get_slot(i,0).slot_updated.connect(_on_ui_slot_update)
		slot.inventory_slot = player.get_inventory_component().get_slot(i, 0)
		hotbar_slots.append(slot)
		add_child(slot)
		
		
func _on_ui_slot_update(x_num : int, y_num : int):
	hotbar_slots[x_num].update_slot()
	hotbar_slots[x_num].update_selection()
