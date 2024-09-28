class_name InventoryMenu
extends Control

# Constants
const UI_SLOT_SCENE = preload("res://Scenes/UI/GameUI/Inventory/InventorySlotUI.tscn")
# Instance Data
var inventory_slots = []
var hovered_slot
var hover_menu

# Functions
func _ready():
	var player_inventory = Utils.get_player().get_inventory_component()
	for i in 40:
		var slot = UI_SLOT_SCENE.instantiate()
		slot.inventory_slot = player_inventory.get_slot(i)
		player_inventory.get_slot(i).slot_updated.connect(slot.update_slot)
		slot.hovered.connect(_on_slot_hover)
		slot.unhovered.connect(_on_slot_unhover)
		inventory_slots.append(slot)
		$Inventory.add_child(slot)


func _on_slot_hover(slot):
	hovered_slot = slot
	hovered_slot.hovering = true
			
			
func _on_slot_unhover(slot):
	hovered_slot.hovering = false
	hovered_slot = null
	
		

	
