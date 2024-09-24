extends Node2D
class_name InventorySlot

# Export Variables
@export var item : Item

# Instance Variables
var count : int = 0
var is_selected = false
var x : int
var y : int
var ui_slot

# Signals
signal updateUI(x_num : int, y_num : int)

# Functions
# Increments the count by 1
func increment():
	count = count + 1
	updateUI.emit(x,y)
	
# Deincrmeents the count by 1
func deincrement():
	count = count - 1
	updateUI.emit(x,y)

# Returns the slot in string format
func toString():
	var string = ""
	if(item == null):
		string = string + "None "
	else:
		string = string + str(item.getName())
	string = string + ", " + str(count)
	return string
	
# Sets the item of the slot using the Item parameter
func setItem(new_item : Item):
	item = new_item
	updateUI.emit(x,y)
	
# Returns the item contained in the slot
func getItem():
	return item
	
# Sets the count of the slot using the int parameter
func setCount(new_count : int):
	count = new_count
	updateUI.emit(x,y)
	
# Returns the count of the slot
func getCount():
	return count
	
# Selects the slot
func select():
	is_selected = true
	updateUI.emit(x,y)

# Deselects the slot
func deselect():
	is_selected = false
	updateUI.emit(x,y)
	
# Returns true if the slot has a count == 0, else returns false
func isEmpty():
	if(item == null):
		return true
	else:
		return false
		
# Clears the slot, setting its count = 0, item = null
func clear():
	count = 0
	item = null
	updateUI.emit(x, y)
	
