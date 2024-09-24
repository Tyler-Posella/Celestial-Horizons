extends Node2D
class_name InventoryComponent

# Constants
const slot_base = preload("res://Scenes/Inventory/InventorySlot.tscn")
const collectable_scene = preload("res://Scenes/Objects/Collectable.tscn")

# Scene Variables
@onready var selected : InventorySlot

# Instance Variables
var size_y : int = 4
var size_x : int = 10
var total_size : int = size_y * size_x
var slots : Array = [[]]
var selected_num = 0

# Signals
signal health_changed(count : int)
signal sound_emitted(sound)
signal item_dropped(item : Item)

# Functions
func _ready():
	for i in size_y:
		slots.append([])
		for j in size_x:
			var slot = slot_base.instantiate()
			slot.item = null
			slot.x = j
			slot.y = i
			slots[i].append(slot)
			add_child(slot)
	selected = slots[0][0]
	
# Adds a number of items to the inventory
func addItem(item_to_add : Item, amount : int):
	# First attempt to find a slot already holding the item to add the new items to
	for i in size_y:
		for j in size_x:
			if(slots[i][j].getItem() == item_to_add):
				slots[i][j].setCount(slots[i][j].getCount() + amount)
				return true
	# Otherwise add the items to the first empty inventory slot
	for i in size_y:
		for j in size_x:
			if(slots[i][j].getItem() == null):
				slots[i][j].setItem(item_to_add)
				slots[i][j].setCount(amount)
				return true
	
# Picks an item up 
func pickupItem(item_to_add : Item):
	# First attempt to find a slot already holding the item to add the new items to
	for i in size_y:
		for j in size_x:
			if(slots[i][j].getItem() == item_to_add):
				slots[i][j].increment()
				sound_emitted.emit("res://Audio/SFX/Inventory/CollectItem.wav")
				return true
	# Otherwise add the items to the first empty inventory slot
	for i in size_y:
		for j in size_x:
			if(slots[i][j].getItem() == null):
				slots[i][j].setItem(item_to_add)
				slots[i][j].increment()
				sound_emitted.emit("res://Audio/SFX/Inventory/CollectItem.wav")
				return true
	
# Drops the item currently selected
func dropItem():
	if(selected.getCount() == 1):
		var item_dropped = collectable_scene.instantiate()
		item_dropped.item = selected.getItem()
		selected.deincrement()
		selected.setItem(null)
		item_dropped.global_position = get_parent().getDropMarker().global_position
		Utils.getLevel().add_child(item_dropped)
	if(selected.getCount() > 1):
		var item_dropped = collectable_scene.instantiate()
		item_dropped.item = selected.getItem()
		selected.deincrement()
		item_dropped.global_position = get_parent().getDropMarker().global_position
		Utils.getLevel().add_child(item_dropped)
		
# Removes a set number of a specific item from the inventory
func removeItem(obj : Item, num : int):
	if(hasItem(obj) == true):
		var slot = findItem(obj)
		var slot_x = slot[0]
		var slot_y = slot[1]
		if(slots[slot_x][slot_y].getCount() < num):
			return false
		else:
			slots[slot_x][slot_y].setCount(slots[slot_x][slot_y].getCount() - num)
			return true
	
# Returns true if the item is in the inventory, else returns false
func hasItem(obj : Item):
	for i in size_y:
		for j in size_x:
			if(slots[i][j].getItem() == obj):
				return true
	return false
	
# Finds a slot containing the specified item
func findItem(obj : Item):
	var found_slot = []
	for i in size_y:
		for j in size_x:
			if(slots[i][j].getItem() == obj):
				found_slot.append(i)
				found_slot.append(j)
				return found_slot

# Prints the inventory in string format
func toString():
	var string : String
	for i in size_y:
		string = ""
		for j in size_x:
			string = string + "[" + slots[i][j].toString() + "]    "
			if(j == size_x - 1):
				print(string)

# Returns the slot at (x,y)
func getSlot(x_num : int, y_num : int):
	return slots[y_num][x_num]
	
# Selects the slot at (x,y)
func selectSlot(x_num : int, y_num : int):
	selected.deselect()
	slots[y_num][x_num].select()
	selected = slots[y_num][x_num]
	selected_num = x_num
	
