extends Node2D

class_name InventorySlot

@export var item : Item
var count : int = 0
var is_selected = false
var x : int
var y : int
var ui_slot

signal updateUI(x_num : int, y_num : int)

func _ready():
	pass
	
func increment():
	count = count + 1
	updateUI.emit(x,y)
	
func deincrement():
	count = count - 1
	updateUI.emit(x,y)

func toString():
	var string = ""
	if(item == null):
		string = string + "None "
	else:
		string = string + str(item.getName())
	string = string + ", " + str(count)
	return string
	
func setItem(obj : Item):
	item = obj
	updateUI.emit(x,y)
	
func getItem():
	return item
	
func setCount(obj : int):
	count = obj
	updateUI.emit(x,y)
	
func getCount():
	return count
	
func select():
	is_selected = true
	updateUI.emit(x,y)

func deselect():
	is_selected = false
	updateUI.emit(x,y)
	
