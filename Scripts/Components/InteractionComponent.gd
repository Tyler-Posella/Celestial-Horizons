class_name InteractionComponent
extends Node2D

signal interacted(interacting_body : Node2D)
# Variables
var player_present : bool = false
var player_body : Node2D

# Functions
func _on_area_2d_body_entered(body: Node2D) -> void:
	if(body.is_in_group("Player")):
		player_present = true
		player_body = body
		print("enter")


func _on_area_2d_body_exited(body: Node2D) -> void:
	if(body.is_in_group("Player")):
		player_present = false
		player_body = null
		print("leave")

func _process(delta):
	if player_present and Input.is_action_just_pressed("interact"):
		interacted.emit(player_body)
