class_name HarvestComponent
extends Node2D

#Signals 
signal died()

# Variables
var hitpoints : int

# Signals
signal hit_by_tool(tool_damage : int)

# Functions
func _on_harvester_area_entered(area): # On axe hitbox entered tree hitbox	
	hit_by_tool.emit(1)
	

func get_hit_points():
	return hitpoints
	
	
func set_hitpoints(new_hitpoints : int):
	hitpoints = new_hitpoints
	
	
func damage(damage : int):
	hitpoints = hitpoints - damage
	if(hitpoints == 0 or 0 > hitpoints):
		died.emit()
