extends Node

var items = {
	"0": {"name": "None", "path": "None"},
	# Tools [0-99]
	"1": {"name": "Axe", "path": "res://Resoures/Tools/Axe.tres"},
	"2": {"name": "Hoe", "path": "res://Resoures/Tools/Hoe.tres"},
	"3": {"name": "Watering Can", "path": "res://Resoures/Tools/WateringCan.tres"},
	# Fuits [100-199]
	"100": {"name": "Apple", "path": "res://Resoures/Fruit/Apple.tres"},
	"101": {"name": "Orange", "path": "res://Resoures/Fruit/Orange.tres"},
	"102": {"name": "Peach", "path": "res://Resoures/Fruit/Peach.tres"},
	"103": {"name": "Pear", "path": "res://Resoures/Fruit/Pear.tres"},
	# Vegtables [200-299]
	# Harvestables [300-399]
}

func get_item_data(item_id : int):
	var key = str(item_id)  # Convert item_id to string for dictionary lookup
	if items.has(key):
		return items[key]
	else:
		print("Item not found for ID: ", item_id)
		return null


func get_item_id(item_name: String) -> int:
	for id in items.keys():
		if items[id]["name"] == item_name:
			return int(id)  # Return the ID as an integer
	print("Item not found with name: ", item_name)
	return -1  # Return -1 if not found


func get_item_path(item_id: int) -> String:
	var key = str(item_id)  # Convert item_id to string for dictionary lookup
	if items.has(key):
		return items[key]["path"]
	else:
		print("Item not found for ID: ", item_id)
		return "None"  # Return "None" if not found
