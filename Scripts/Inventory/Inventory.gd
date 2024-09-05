extends Node2D
class_name InventoryComponent

const slot_base = preload("res://Scenes/Inventory/InventorySlot.tscn")
const collectable_scene = preload("res://Scenes/Objects/Collectable.tscn")
var size_y : int = 4
var size_x : int = 10
var total_size : int = size_y * size_x
var slots : Array = [[]]
var selected_num = 0
@onready var selected : InventorySlot

signal healthChanged(count : int)

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
	
func addItem(item_to_add : Item, amount : int):
	for i in size_y:
		for j in size_x:
			if(slots[i][j].getItem() == item_to_add):
				slots[i][j].setCount(slots[i][j].getCount() + amount)
				return true
				
	for i in size_y:
		for j in size_x:
			if(slots[i][j].getItem() == null):
				slots[i][j].setItem(item_to_add)
				slots[i][j].setCount(amount)
				return true
	
func pickupItem(item_to_add : Item):
	for i in size_y:
		for j in size_x:
			if(slots[i][j].getItem() == item_to_add):
				slots[i][j].increment()
				Utils.getGameAudio().playSound("res://Audio/SFX/Inventory/CollectItem.wav")
				return true
	
	for i in size_y:
		for j in size_x:
			if(slots[i][j].getItem() == null):
				slots[i][j].setItem(item_to_add)
				slots[i][j].increment()
				Utils.getGameAudio().playSound("res://Audio/SFX/Inventory/CollectItem.wav")
				return true
	
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
	
func hasItem(obj : Item):
	for i in size_y:
		for j in size_x:
			if(slots[i][j].getItem() == obj):
				return true
	return false
	
func findItem(obj : Item):
	var found_slot = []
	for i in size_y:
		for j in size_x:
			if(slots[i][j].getItem() == obj):
				found_slot.append(i)
				found_slot.append(j)
				return found_slot

func toString():
	var string : String
	for i in size_y:
		string = ""
		for j in size_x:
			string = string + "[" + slots[i][j].toString() + "]    "
			if(j == size_x - 1):
				print(string)

func getSlot(x_num : int, y_num : int):
	return slots[y_num][x_num]
	
func selectSlot(x_num : int, y_num : int):
	selected.deselect()
	slots[y_num][x_num].select()
	selected = slots[y_num][x_num]
	selected_num = x_num
	
