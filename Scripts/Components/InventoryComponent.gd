class_name InventoryComponent
extends Node2D

# Signals
signal health_changed(count : int)
signal sound_emitted(sound)
signal item_dropped(item : Item)

# Constants
const SLOT_BASE = preload("res://Scenes/Inventory/InventorySlot.tscn")
const COLLECTABLE_SCENE = preload("res://Scenes/Objects/Collectable.tscn")

# Variables
var size : int = 40
var slots : Array = []
var selected_num = 0
var selected : InventorySlot

# Functions
func _ready():
	if(slots.size() == size):
		pass
	else:
		for i in size:
			var slot = SLOT_BASE.instantiate()
			slot.item = null
			slots.append(slot)
			add_child(slot)
			selected = slots[0]
	slots[0].select()
	

func add_item(item_to_add : Item, amount : int): # Adds a number of items to the inventory
	# First attempt to find a slot already holding the item to add the new items to
	for i in size:
		if(slots[i].get_item() == item_to_add):
			slots[i].set_count(slots[i].get_count() + amount)
			return true
			
	# Otherwise add the items to the first empty inventory slot
	for i in size:
			if(slots[i].get_item() == null):
				slots[i].set_item(item_to_add)
				slots[i].set_count(amount)
				return true
	

func pickup_item(item_to_add : Item): # Picks an item up 
	# First attempt to find a slot already holding the item to add the new items to
	for i in size:
		if(slots[i].get_item() == item_to_add):
			slots[i].increment()
			sound_emitted.emit("res://Audio/SFX/Inventory/CollectItem.wav")
			return true
	# Otherwise add the items to the first empty inventory slot
	for i in size:
		if(slots[i].get_item() == null):
			slots[i].set_item(item_to_add)
			slots[i].increment()
			sound_emitted.emit("res://Audio/SFX/Inventory/CollectItem.wav")
			return true
	

func drop_item(): # Drops the item currently selected
	if(selected.get_count() == 1):
		var item_dropped = COLLECTABLE_SCENE.instantiate()
		item_dropped.item = selected.get_item()
		selected.deincrement()
		selected.set_item(null)
		item_dropped.global_position = get_parent().get_drop_marker().global_position
		Utils.get_level().add_child(item_dropped)
	if(selected.get_count() > 1):
		var item_dropped = COLLECTABLE_SCENE.instantiate()
		item_dropped.item = selected.get_item()
		selected.deincrement()
		item_dropped.global_position = get_parent().get_drop_marker().global_position
		Utils.get_level().add_child(item_dropped)
	

func has_item(obj : Item): # Returns true if the item is in the inventory, else returns false
	for i in size:
		if(slots[i].get_item() == obj):
			return true
	return false
	

func find_slots_with_item(obj : Item): # Finds a slot containing the specified item
	var found_slots = []
	for i in size:
		if(slots[i].get_item() == obj):
			found_slots.append(slots[i])
	return found_slots
				

func get_slot(slot_num : int): # Returns the slot at slot_num
	return slots[slot_num]
	

func select_slot(slot_num : int): # Selects the slot at slot_num
	selected.deselect()
	slots[slot_num].select()
	selected = slots[slot_num]
	selected_num = slot_num
	

func get_selected_slot():
	return selected
	
