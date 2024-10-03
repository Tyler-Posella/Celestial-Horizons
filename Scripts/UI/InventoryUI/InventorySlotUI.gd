class_name GuiInventorySlot
extends Control

# Signals
signal hovered(node)
signal unhovered(node)
signal movingItem(slot)

# Constant Variables
const INVENTORY_SLOT_SCENE = preload("res://Scenes/UI/GameUI/Inventory/InventorySlotUI.tscn")
const HOVER_SLOT_SCENE = preload("res://Scenes/UI/GameUI/Inventory/ItemHoverMenu.tscn")
const MOVING_ITEM_SCENE = preload("res://Scenes/UI/GameUI/Inventory/MovingItem.tscn")

# Export Variables
@export var inventory_slot : InventorySlot
@export var selected_texture : Texture
@export var unselected_texture : Texture

# Variables
@onready var sprite = $NinePatchRect/ItemSprite
@onready var text_edit = $NinePatchRect/CountText
var hover_menu
var hovering : bool = false


# Functions
func _ready():
	$NinePatchRect.texture = unselected_texture
	update_slot()

func _process(delta: float) -> void:
	if(hovering == true 
		and Input.is_action_pressed("Keyboard-Shift")
		and inventory_slot.is_empty() == false 
		and hover_menu == null
		):
		add_tooltip()
	elif(hovering == false
		or Input.is_action_just_released("Keyboard-Shift")
		):
		remove_tooltip()
		
func update_slot():
	if(inventory_slot.count == 0):
		sprite.texture = null
		text_edit.text = str(0)
		
	if(inventory_slot.get_item() != null):
		sprite.texture = inventory_slot.get_item().texture
		text_edit.text = str(inventory_slot.get_count())
		
	if(inventory_slot.is_selected):
		$NinePatchRect.texture = selected_texture
	
	if(inventory_slot.is_selected == false):
		$NinePatchRect.texture = unselected_texture	


func _on_mouse_entered() -> void:
	hovered.emit(self)

	
func _on_mouse_exited() -> void:
	unhovered.emit(self)
			
			
func add_tooltip():
	var new_hover_menu = HOVER_SLOT_SCENE.instantiate()
	hover_menu = new_hover_menu
	new_hover_menu.z_index = self.z_index + 1
	if(inventory_slot.get_item() != null):
		hover_menu.item = inventory_slot.get_item()
	add_child(new_hover_menu)
	
	
func remove_tooltip():
	if(hover_menu != null):
		hover_menu.queue_free()
	
	
func has_tooltip():
	if(hover_menu != null):
		return true
	else:
		return false


func _on_gui_input(event: InputEvent) -> void:
	if(event.is_action_pressed("click_primary")):
		if(inventory_slot.is_empty() == false and Game.get_ui().moving_item == null):
			var moving_item = MOVING_ITEM_SCENE.instantiate()
			moving_item.set_object(inventory_slot)
			Game.get_ui_node().add_child(moving_item)
			#Make better
			Game.get_ui().moving_item = moving_item
			inventory_slot.set_count(0)
			inventory_slot.set_item(null)
		elif(inventory_slot.is_empty() and Game.get_ui().moving_item != null):
			inventory_slot.set_item(Game.get_ui().moving_item.item)
			inventory_slot.set_count(Game.get_ui().moving_item.count)
			Game.get_ui().moving_item.queue_free()
		elif(inventory_slot.is_empty() == false and Game.get_ui().moving_item != null):
			var moving_item = MOVING_ITEM_SCENE.instantiate()
			moving_item.set_object(inventory_slot)
			Game.get_ui_node().add_child(moving_item)
			#Make better
			inventory_slot.set_item(Game.get_ui().moving_item.item)
			inventory_slot.set_count(Game.get_ui().moving_item.count)
			Game.get_ui().moving_item.queue_free()
			Game.get_ui().moving_item = moving_item
