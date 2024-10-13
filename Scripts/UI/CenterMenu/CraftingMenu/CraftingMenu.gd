class_name CraftingMenu
extends Control


# Functions
func _ready() -> void:
	var craftables = ResourceMaps.get_all_craftable_items()
	for craftable in craftables:
		var new_craftable_scene = load("res://Scenes/UI/CenterMenu/CraftingMenu/CraftableItem.tscn")
		var new_craftable = new_craftable_scene.instantiate()
		new_craftable.set_item(load(craftable["resource_path"]))
		$GridContainer.add_child(new_craftable)
