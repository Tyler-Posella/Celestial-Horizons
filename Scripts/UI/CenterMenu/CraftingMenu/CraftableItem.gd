class_name CraftableItem
extends Control

# Signals

# Constnats
const CRAFTING_TOOLTIP_SCENE = preload("res://Scenes/UI/CenterMenu/CraftingMenu/CraftableItemHover.tscn")
# Variables
var item : ItemRes
var ingredients 
var item_hover_tooltip : CraftableItemHover

# Onready Variables
@onready var item_texture = $MarginContainer/AspectRatioContainer/TextureRect

# Functions
func _ready():
	if(item != null):
		item_texture.texture = item.get_texture()
		ingredients = ResourceMaps.get_craftable_recipie(ResourceMaps.get_item_id_by_name(item.get_item_name()))
		

func set_item(new_item : ItemRes):
	item = new_item


func _on_texture_rect_mouse_entered() -> void:
	item_hover_tooltip = CRAFTING_TOOLTIP_SCENE.instantiate()
	item_hover_tooltip.ingredients = self.ingredients
	$MarginContainer/AspectRatioContainer/TextureRect.add_child(item_hover_tooltip)


func _on_texture_rect_mouse_exited() -> void:
	item_hover_tooltip.queue_free()
	

func _on_gui_input(event: InputEvent):
	if(event.is_action_pressed("click_primary")):
		var inventory = Game.get_player().get_inventory_component()
		# Find slots with ingredients
		var slots_to_use = []
		var amount_to_remove = []
		for ingredient in ingredients:
			var total : int = 0
			var resource_path = ingredient["resource_path"]
			var resource = load(resource_path)
			var searching_slots = inventory.find_slots_with_item(resource)
			if(searching_slots == []):
				print("Items not found")
				break
			else:
				var have = searching_slots[0].get_count()
				var need = int(ingredient["count"])
				if(have >= need):
					slots_to_use.append(searching_slots[0])
					amount_to_remove.append(need)
					searching_slots = []
					
		for i in slots_to_use.size():
			slots_to_use[i].set_count(slots_to_use[i].get_count() - amount_to_remove[i])
		
		inventory.add_item(item, 1)
			
		
			
