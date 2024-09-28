class_name InventorySlot
extends Node2D

# Signals
signal slot_updated(x_num : int, y_num : int)

# Export Variables
@export var item : Item

# Variables
var count : int = 0
var is_selected = false
var x : int
var y : int

# Functions
func increment(): # Increments the count by 1
	count = count + 1
	slot_updated.emit(x,y)
	

func deincrement(): # Deincrmeents the count by 1
	count = count - 1
	slot_updated.emit(x,y)


func set_item(new_item : Item): # Sets the item of the slot using the Item parameter
	item = new_item
	slot_updated.emit(x,y)
	

func get_item(): # Returns the item contained in the slot
	return item
	

func set_count(new_count : int): # Sets the count of the slot using the int parameter
	count = new_count
	slot_updated.emit(x,y)
	

func get_count(): # Returns the count of the slot
	return count
	

func select(): # Selects the slot
	is_selected = true
	slot_updated.emit(x,y)


func deselect(): # Deselects the slot
	is_selected = false
	slot_updated.emit(x,y)
	

func is_empty(): # Returns true if the slot has a count == 0, else returns false
	if(item == null):
		return true
	else:
		return false
		

func clear(): # Clears the slot, setting its count = 0, item = null
	count = 0
	item = null
	slot_updated.emit(x, y)
	
