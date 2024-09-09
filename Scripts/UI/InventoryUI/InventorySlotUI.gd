extends Control
class_name GuiInventorySlot
# Constant Variables
const hover_slot_scene = preload("res://Scenes/UI/GameUI/Inventory/ItemHoverMenu.tscn")
const inventory_slot_scene = preload("res://Scenes/UI/GameUI/Inventory/InventorySlotUI.tscn")

# Export Variables
@export var inventory_slot : InventorySlot
@export var selected_texture : Texture
@export var unselected_texture : Texture

# Instance Variables
@onready var sprite = $NinePatchRect/ItemSprite
@onready var text_edit = $NinePatchRect/CountText
var hovering : bool = false
var hover_menu
var mouse_in = false

# Signals


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
	if(Debug.isDebugging()):
		print("Mouse entered")
	
	if(inventory_slot.isEmpty() == false):
		hovering = true
		
	
func _on_mouse_exited() -> void:
	if(Debug.isDebugging()):
		print("Mouse exited")
	
	if(inventory_slot.isEmpty() == false):
		hovering = false
		if(hover_menu != null):
			hover_menu.queue_free()


func _on_gui_input(event: InputEvent) -> void:
	if(event is InputEventKey):
		if(event.is_pressed and event.keycode == KEY_SHIFT):
			var new_hover_menu = hover_slot_scene.instantiate()
			hover_menu = new_hover_menu
			hover_menu.z_index = self.z_index + 1
			hover_menu.setItem(inventory_slot.getItem())
			add_child(new_hover_menu)
