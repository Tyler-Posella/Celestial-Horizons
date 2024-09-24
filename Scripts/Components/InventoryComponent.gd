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
var size_y : int = 4
var size_x : int = 10
var total_size : int = size_y * size_x
var slots : Array = [[]]
var selected_num = 0

# Onready Variables
@onready var selected : InventorySlot

# Functions
func _ready():
	for i in size_y:
		slots.append([])
		for j in size_x:
			var slot = SLOT_BASE.instantiate()
			slot.item = null
			slot.x = j
			slot.y = i
			slots[i].append(slot)
			add_child(slot)
	selected = slots[0][0]
	

func add_item(item_to_add : Item, amount : int): # Adds a number of items to the inventory
	# First attempt to find a slot already holding the item to add the new items to
	for i in size_y:
		for j in size_x:
			if(slots[i][j].get_item() == item_to_add):
				slots[i][j].set_count(slots[i][j].get_count() + amount)
				return true
	# Otherwise add the items to the first empty inventory slot
	for i in size_y:
		for j in size_x:
			if(slots[i][j].get_item() == null):
				slots[i][j].set_item(item_to_add)
				slots[i][j].set_count(amount)
				return true
	

func pickup_item(item_to_add : Item): # Picks an item up 
	# First attempt to find a slot already holding the item to add the new items to
	for i in size_y:
		for j in size_x:
			if(slots[i][j].get_item() == item_to_add):
				slots[i][j].increment()
				sound_emitted.emit("res://Audio/SFX/Inventory/CollectItem.wav")
				return true
	# Otherwise add the items to the first empty inventory slot
	for i in size_y:
		for j in size_x:
			if(slots[i][j].get_item() == null):
				slots[i][j].set_item(item_to_add)
				slots[i][j].increment()
				sound_emitted.emit("res://Audio/SFX/Inventory/CollectItem.wav")
				return true
	

func dropItem(): # Drops the item currently selected
	if(selected.get_count() == 1):
		var item_dropped = COLLECTABLE_SCENE.instantiate()
		item_dropped.item = selected.get_item()
		selected.deincrement()
		selected.setItem(null)
		item_dropped.global_position = get_parent().get_drop_marker().global_position
		Utils.get_level().add_child(item_dropped)
	if(selected.get_count() > 1):
		var item_dropped = COLLECTABLE_SCENE.instantiate()
		item_dropped.item = selected.get_item()
		selected.deincrement()
		item_dropped.global_position = get_parent().get_drop_marker().global_position
		Utils.get_level().add_child(item_dropped)
		

func remove_item(obj : Item, num : int): # Removes a set number of a specific item from the inventory
	if(has_item(obj) == true):
		var slot = find_item(obj)
		var slot_x = slot[0]
		var slot_y = slot[1]
		if(slots[slot_x][slot_y].get_count() < num):
			return false
		else:
			slots[slot_x][slot_y].set_count(slots[slot_x][slot_y].get_count() - num)
			return true
	

func has_item(obj : Item): # Returns true if the item is in the inventory, else returns false
	for i in size_y:
		for j in size_x:
			if(slots[i][j].get_item() == obj):
				return true
	return false
	
# Finds a slot containing the specified item
func find_item(obj : Item):
	var found_slot = []
	for i in size_y:
		for j in size_x:
			if(slots[i][j].get_item() == obj):
				found_slot.append(i)
				found_slot.append(j)
				return found_slot
				

func get_slot(x_num : int, y_num : int): # Returns the slot at (x,y)
	return slots[y_num][x_num]
	

func select_slot(x_num : int, y_num : int): # Selects the slot at (x,y)
	selected.deselect()
	slots[y_num][x_num].select()
	selected = slots[y_num][x_num]
	selected_num = x_num
	
