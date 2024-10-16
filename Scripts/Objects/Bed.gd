class_name Bed
extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _on_interactable_component_interacted() -> void:
		# Handle sleeping mechanic
	print("Bed Interacted")
