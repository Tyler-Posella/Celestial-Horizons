class_name StumpObject
extends Node2D

# Onready Variables
@onready var health_component = $HealthComponent
@onready var harvest_component = $HarvestComponent

# Functions
func die(): # Kills the tree
	var collectable_scene = load("res://Scenes/Objects/Collectable.tscn")
	var new_collectable = collectable_scene.instantiate()
	new_collectable.set_item()
	get_parent().add_child(new_collectable)
	queue_free()
	

func _on_harvest_component_hit_by_tool(tool_damage: int) -> void:
	harvest_component.damage(tool_damage)
