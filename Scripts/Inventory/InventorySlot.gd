class_name InventorySlot
extends Node2D

# Signals
signal slot_updated()

# Variables
var count : int = 0
var item : ItemRes
var item_id : int
var is_selected = false

# Functions
func _ready():
	slot_updated.emit()
	
func increment(): # Increments the count by 1
	count = count + 1
	slot_updated.emit()
	

func deincrement(): # Deincrmeents the count by 1
	count = count - 1
	if(count == 0):
		clear()
	slot_updated.emit()


func set_item(new_item : ItemRes): # Sets the item of the slot using the Item parameter
	item = new_item
	slot_updated.emit()
	

func get_item(): # Returns the item contained in the slot
	return item
	

func get_item_id(): # Returns the item id contained in the slot
	return item_id
	

func set_count(new_count : int): # Sets the count of the slot using the int parameter
	count = new_count
	if(count == 0):
		clear()
	slot_updated.emit()
	

func get_count(): # Returns the count of the slot
	return count
	

func select(): # Selects the slot
	is_selected = true
	slot_updated.emit()


func deselect(): # Deselects the slot
	is_selected = false
	slot_updated.emit()
	

func is_empty(): # Returns true if the slot has a count == 0, else returns false
	if(item == null):
		return true
	else:
		return false
		

func clear(): # Clears the slot, setting its count = 0, item = null
	count = 0
	item = null
	slot_updated.emit()
	item_id = 0
  
  
func save():
	if(item != null):
		item_id = ResourceMaps.get_item_id_by_name(item.get_item_name())
	else: item_id = 0
	
	var save_dict = {
		"scene" : get_scene_file_path(),
		"properties" : {
			"count" : count,
			"item_id" : item_id,
		},
		"unique" : false
	}
	return save_dict

	
