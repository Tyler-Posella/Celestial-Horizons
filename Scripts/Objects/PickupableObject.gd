class_name PickableObject
extends GridObject

# Export Variables
@export var pickable : PickableRes

# Onready Variables
@onready var sprite : Sprite2D = $Sprite2D
@onready var harvest_component : HarvestComponent = $HarvestComponent

# Functions
func _ready():
	harvest_component.set_hitpoints(1)
	sprite.texture = pickable.get_texture()


func _on_harvest_component_died() -> void:
	var collectable_scene = load("res://Scenes/Objects/Collectable.tscn")
	var new_collectable = collectable_scene.instantiate()
	new_collectable.set_item(pickable.get_item())
	new_collectable.global_position = self.global_position
	get_parent().add_child(new_collectable)
	self.queue_free()
