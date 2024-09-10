extends Control
class_name GuiInventorySlot
# Constant Variables
const inventory_slot_scene = preload("res://Scenes/UI/GameUI/Inventory/InventorySlotUI.tscn")
const hover_slot_scene = preload("res://Scenes/UI/GameUI/Inventory/ItemHoverMenu.tscn")
const moving_item_scene = preload("res://Scenes/UI/GameUI/Inventory/MovingItem.tscn")
# Export Variables
@export var inventory_slot : InventorySlot
@export var selected_texture : Texture
@export var unselected_texture : Texture

# Instance Variables
@onready var sprite = $NinePatchRect/ItemSprite
@onready var text_edit = $NinePatchRect/CountText
var hover_menu

# Signals
signal hovered(node)
signal unhovered(node)
signal movingItem(slot)
# Functions
func debug():
	if(inventory_slot == null):
		var new_slot_scene = inventory_slot_scene.instantiate()
		inventory_slot = new_slot_scene
		
		
func _ready():
	debug()
	$NinePatchRect.texture = unselected_texture
	updateSlot()

		
func updateSlot():
	if(inventory_slot.count == 0):
		sprite.texture = null
		text_edit.text = str(0)
		
	if(inventory_slot.getItem() != null):
		sprite.texture = inventory_slot.getItem().texture
		text_edit.text = str(inventory_slot.getCount())
		
		
func updateSelection():
	if(inventory_slot.is_selected):
		$NinePatchRect.texture = selected_texture
		
	if(inventory_slot.is_selected == false):
		$NinePatchRect.texture = unselected_texture


func _on_mouse_entered() -> void:
	hovered.emit(self)

	
func _on_mouse_exited() -> void:
	unhovered.emit(self)
			
			
func addTooltip():
	var new_hover_menu = hover_slot_scene.instantiate()
	hover_menu = new_hover_menu
	new_hover_menu.z_index = self.z_index + 1
	if(inventory_slot.getItem() != null):
		hover_menu.item = inventory_slot.getItem()
	add_child(new_hover_menu)
	
	
func removeTooltip():
	if(hover_menu != null):
		hover_menu.queue_free()
	
	
func hasTooltip():
	if(hover_menu != null):
		return true
	else:
		return false
		

func _on_gui_input(event: InputEvent) -> void:
	if(event.is_action_pressed("click_primary")):
		if(inventory_slot.isEmpty() == false and Utils.getUI().moving_item == null):
			var moving_item = moving_item_scene.instantiate()
			moving_item.setObject(inventory_slot)
			Utils.getGameUi().add_child(moving_item)
			#Make better
			Utils.getUI().moving_item = moving_item
			inventory_slot.setCount(0)
			inventory_slot.setItem(null)
		elif(inventory_slot.isEmpty() and Utils.getUI().moving_item != null):
			inventory_slot.setItem(Utils.getUI().moving_item.item)
			inventory_slot.setCount(Utils.getUI().moving_item.count)
			Utils.getUI().moving_item.queue_free()
		elif(inventory_slot.isEmpty() == false and Utils.getUI().moving_item != null):
			var moving_item = moving_item_scene.instantiate()
			moving_item.setObject(inventory_slot)
			Utils.getGameUi().add_child(moving_item)
			#Make better
			inventory_slot.setItem(Utils.getUI().moving_item.item)
			inventory_slot.setCount(Utils.getUI().moving_item.count)
			Utils.getUI().moving_item.queue_free()
			Utils.getUI().moving_item = moving_item
