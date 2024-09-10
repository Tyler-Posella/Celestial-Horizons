extends Control
class_name InventoryMenu
# Constants
const ui_slot_scene = preload("res://Scenes/UI/GameUI/Inventory/InventorySlotUI.tscn")
# Instance Data
var player
var inventory_slots = []
var hotbar_slots = []
var hovered_slot
var hover_menu

# Functions
func _ready():
#Player data imported
	player = Utils.getPlayer()
	var player_inventory = player.getInventoryComponent()
	for i in 4:
		inventory_slots.append([])
		for j in 10:
			var slot = ui_slot_scene.instantiate()
			slot.inventory_slot = player_inventory.getSlot(j, i)
			player_inventory.getSlot(j,i).updateUI.connect(_on_ui_slot_update)
			slot.hovered.connect(_on_slot_hover)
			slot.unhovered.connect(_on_slot_unhover)
			inventory_slots[i].append(slot)
			$Inventory.add_child(slot)
		
		
func _on_ui_slot_update(x_num : int, y_num : int):
	inventory_slots[y_num][x_num].updateSlot()


func _on_slot_hover(slot):
	hovered_slot = slot
	if(hovered_slot.inventory_slot.item != null):
		hovered_slot.addTooltip()
			
			
func _on_slot_unhover(slot):
	if(hovered_slot == null):
		pass
	else:
		hovered_slot.removeTooltip()
		hovered_slot = null
	
		

	
