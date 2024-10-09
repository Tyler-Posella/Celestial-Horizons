class_name ItemGravityComponent
extends Node2D

# Export Variables
@export var desired_radius : float
# Called when the node enters the scene tree for the first time.


func _ready():
	$Area2D/CollisionShape2D.shape.radius = desired_radius
