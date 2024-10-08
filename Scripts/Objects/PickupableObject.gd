class_name PickupableObject
extends Node2D

# Export Variables
@export var pickupable : PickupableRes

# Onready Variables
@onready var sprite : Sprite2D = $Sprite2D

# Functions
func _ready():
	sprite.texture = pickupable.get_texture()


func _on_interactable_component_interacted(interacting_body: Node2D) -> void:
	interacting_body.get_inventory_component().pickup_item(pickupable.get_item())
	self.queue_free()
