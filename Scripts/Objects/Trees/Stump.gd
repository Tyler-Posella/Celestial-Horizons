class_name StumpObject
extends Node2D

# Onready Variables
@onready var harvest_component = $HarvestComponent
@onready var audio_component = $AudioMachine

# Functions
func _ready():
	harvest_component.set_hitpoints(3)
	
	
func _on_harvest_component_died() -> void:
	await audio_component.stream_array[0].finished
	var collectable_scene = load("res://Scenes/Objects/Collectable.tscn")
	var new_collectable = collectable_scene.instantiate()
	new_collectable.set_item(load("res://Resoures/Harvestables/Tree/Log.tres"))
	new_collectable.global_position = self.global_position
	get_parent().add_child(new_collectable)
	queue_free()


func _on_harvest_component_hit() -> void:
	audio_component.play_sound("res://Audio/SFX/Tree/TreeHit.wav")
