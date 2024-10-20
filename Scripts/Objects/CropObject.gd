class_name CropObject
extends Node2D

# Variables
@export var type : PlantedCropRes
var harvestable : bool

# Onready Variables
@onready var animation_player = $AnimationPlayer
@onready var two_sprite = $TwoHSprite
@onready var one_sprite = $OneHSprite
@onready var growable_component = $GrowableComponent
@onready var interaction_component = $InteractableComponent

# Functions
func _ready() -> void:
	growable_component.set_growable(type)
	one_sprite.frame_coords = Vector2(growable_component.age, type.get_texture_row())

	
func _on_growable_component_stage_advanced() -> void:
	one_sprite.frame_coords = Vector2(growable_component.age, type.get_texture_row())
	
	
func _on_interactable_component_interacted() -> void:
	if(growable_component.age == growable_component.growtime):
		print("Harvest")
		growable_component.age = 0
		one_sprite.frame_coords = Vector2(growable_component.age, type.get_texture_row())
		harvest()
	else:
		print("Cant harvest yet")
		

func harvest():
	var new_collectable_scene = load("res://Scenes/Objects/Collectable.tscn")
	var new_collectable = new_collectable_scene.instantiate()
	new_collectable.set_item(type.get_harvest_item())
	new_collectable.global_position = self.global_position
	get_parent().add_child(new_collectable)
