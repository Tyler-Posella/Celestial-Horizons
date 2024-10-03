extends GridContainer

# Constants
const UI_SLOT_SCENE = preload("res://Scenes/UI/GameUI/Inventory/InventorySlotUI.tscn")

# Variables
var hotbar_slots = []

# Functions
func _ready():
	var player = Game.get_player()
	for i in 10:
		var slot = UI_SLOT_SCENE.instantiate()
		player.get_inventory_component().get_slot(i).slot_updated.connect(slot.update_slot)
		slot.inventory_slot = player.get_inventory_component().get_slot(i)
		hotbar_slots.append(slot)
		add_child(slot)
	
		
