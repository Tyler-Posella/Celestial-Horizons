class_name HarvestComponent
extends Node2D

#Signals 
signal died()
signal hit()

# Variables
var hitpoints : int
@export var harvest_layer : int

# Functions
func _ready():
	if(harvest_layer != 0):
		$HarvestArea.set_collision_mask_value(harvest_layer, true)
	
func _on_harvester_area_entered(area): # On tool hitbox entered tree hitbox
	hit.emit()
	damage(1)
	

func get_hitpoints():
	return hitpoints
	
	
func set_hitpoints(new_hitpoints : int):
	hitpoints = new_hitpoints
	
	
func damage(damage : int):
	hitpoints = hitpoints - damage
	if(hitpoints == 0 or 0 > hitpoints):
		died.emit()
