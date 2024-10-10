extends Node


var items = {
	# Tools 1 - 99
	"null": {
		"0": {
			"item_name": "Empty",
		}
	},
	"tools": {
		"1": {
			"item_name": "Axe",
			"ingredients": [
				{ "item_name": "Small Stone", "count": 3 },
				{ "item_name": "Stick", "count": 2 }
			],
			"craftable": 1,
			"crafting_location": 0,
			"resource_path": "res://Resoures/Tools/Axe.tres"
		},
		"2": {
			"item_name": "Hoe",
			"item_type": "Tool",
			"ingredients": [
				{ "item_name": "Small Stone", "count": 2 },
				{ "item_name": "Stick", "count": 2 }
			],
			"craftable": 1,
			"crafting_location": 0,
			"resource_path": "res://Resoures/Tools/Hoe.tres"
		 }
	},
	# Fruit 100 - 199
	"fruit": {
		"100": {
			"name": "Apple",
			"path": "res://Resoures/Fruit/Apple.tres"
		},
		"101": {
			"name": "Orange",
			"resource_path": "res://Resoures/Fruit/Orange.tres"
		},
		"102": {
			"name": "Peach",
			"resource_path": "res://Resoures/Fruit/Peach.tres"
		},
		"103": {
			"name": "Pear",
			"resource_path": "res://Resoures/Fruit/Pear.tres"
		},
	},
	# Harvestables 200 - 299
	"harvestables": {
		"200": {
			"name": "Branch",
			"resource_path": "res://Resoures/Items/Trees/Branch.tres"
		},
		"201": {
			"name": "Log",
			"resource_path": "res://Resoures/Items/Trees/Log.tres"
		},
		"202": {
			"name": "Twig",
			"resource_path": "res://Resoures/Items/Trees/Twig.tres"
		},
		"203": {
			"name": "Small Stone",
			"resource_path": "res://Resoures/Items/Rocks/SmallStone.tres"
		},
		"204": {
			"name": "Stone",
			"resource_path": "res://Resoures/Items/Rocks/Stone.tres"
		},
	}
}

func get_item_data(item_id : int):
	# Loop through the subcategories (tools, fruit, etc.)
	for category in items.values():
		if category.has(str(item_id)):  # Check if the ID exists in this category
			return category[str(item_id)]  # Return the item if found
	return null  # Return null if not found


func get_item_id_by_name(target_name):
	# Loop through each category (tools, fruit, etc.)
	for category_name in items.keys():
		var category = items[category_name]
		
		# Loop through each item in the current category
		for item_id in category.keys():
			var item = category[item_id]
			
			# Check for both "item_name" (for tools) and "name" (for fruit)
			if item.has("item_name") and item["item_name"] == target_name:
				return int(item_id)  # Return the ID as a string
			elif item.has("name") and item["name"] == target_name:
				return int(item_id)  # Return the ID as a string
	
	# Return -1 if the item is not found
	return int(-1)



func get_item_path(item_id: int) -> String:
	# Loop through each category (tools, fruit, etc.)
	for category_name in items.keys():
		var category = items[category_name]
		
		# Check if the item ID exists in this category
		if category.has(str(item_id)):  # Convert item_id to string since keys are stored as strings
			var item = category[str(item_id)]
			
			# Check if the item has a resource_path and return it
			if item.has("resource_path"):
				return item["resource_path"]
	
	# Return null if the item or resource_path is not found
	return "Error"
