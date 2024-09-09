extends Control
class_name InventoryMenu
# Constants
const ui_slot_scene = preload("res://Scenes/UI/GameUI/Inventory/InventorySlotUI.tscn")

# Instance Data
var player
var inventory_slots = []
var hotbar_slots = []

# Functions
func _ready():
#Player data imported
	player = Utils.getPlayer()
	var player_inventory = player.getInventoryComponent()
	var player_currency = player.getCurrencyComponent()
	var player_health = player.getHealthComponent()
	for i in 4:
		inventory_slots.append([])
		for j in 10:
			var slot = ui_slot_scene.instantiate()
			slot.inventory_slot = player_inventory.getSlot(j, i)
			player_inventory.getSlot(j,i).updateUI.connect(_on_ui_slot_update)
			inventory_slots[i].append(slot)
			$Inventory.add_child(slot)
		
		
func _on_ui_slot_update(x_num : int, y_num : int):
	inventory_slots[y_num][x_num].updateSlot()
			

	
