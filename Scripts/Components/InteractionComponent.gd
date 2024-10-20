class_name InteractionComponent
extends Node2D

# Signals
signal interacted()

# Variables
var player_present
var player_body

# Export Variables

# Functions
func _on_area_2d_body_entered(body: Node2D) -> void:
	print("Player entered")
	if(body.is_in_group("Player")):
		player_present = true
		player_body = body


func _on_area_2d_body_exited(body: Node2D) -> void:
	if(body.is_in_group("Player")):
		player_present = false
		player_body = null


func _process(delta):
	if(player_present and Input.is_action_just_pressed("interact")):
		interacted.emit()
