extends Control
class_name InventoryMenu
# Constants
const UI_SLOT_SCENE = preload("res://Scenes/UI/GameUI/Inventory/InventorySlotUI.tscn")
# Instance Data
var inventory_slots = []
var hotbar_slots = []
var hovered_slot
var hover_menu

# Functions
func _ready():
	var player_inventory = Utils.get_player().get_inventory_component()
	for i in 4:
		inventory_slots.append([])
		for j in 10:
			var slot = UI_SLOT_SCENE.instantiate()
			slot.inventory_slot = player_inventory.get_slot(j, i)
			player_inventory.get_slot(j,i).slot_updated.connect(_on_ui_slot_update)
			slot.hovered.connect(_on_slot_hover)
			slot.unhovered.connect(_on_slot_unhover)
			inventory_slots[i].append(slot)
			$Inventory.add_child(slot)
		
		
func _on_ui_slot_update(x_num : int, y_num : int):
	inventory_slots[y_num][x_num].update_slot()


func _on_slot_hover(slot):
	hovered_slot = slot
	hovered_slot.hovering = true
			
			
func _on_slot_unhover(slot):
	hovered_slot.hovering = false
	hovered_slot = null
	
		

	
