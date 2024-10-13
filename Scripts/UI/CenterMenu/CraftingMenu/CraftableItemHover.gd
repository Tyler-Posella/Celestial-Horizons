class_name CraftableItemHover
extends Control

# Constnats
const CRAFTING_ITEM_INGREDIENT_SCENE = preload("res://Scenes/UI/CenterMenu/CraftingMenu/CraftingItemIngredient.tscn")
# Variables
var ingredients

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var number_made = 0
	for ingredient in ingredients:
		number_made = number_made + 1
		var new_crafting_ingredient = CRAFTING_ITEM_INGREDIENT_SCENE.instantiate()
		# Check if the item has a "resource_path"
		if ingredient.has("resource_path"):
			var resource_path = ingredient["resource_path"]
			# Load the resource using the resource path
			var resource = load(resource_path)
			new_crafting_ingredient.set_texture(resource.get_texture())
		if ingredient.has("count"):
			new_crafting_ingredient.set_count(ingredient["count"])
		$PanelContainer/HBoxContainer.add_child(new_crafting_ingredient)
		
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func set_craftable(new_craftable : ItemRes):
	pass
