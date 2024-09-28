class_name HealthComponent
extends Node2D


# Signals
signal health_changed(count : int)

# Variables
var max_health : int = 10
var health : int = 10

# Functions
func _ready():
	pass
	

func damage(dmg : int): # Lowers the health by the damage parameter
	health = health - dmg
	health_changed.emit(health)
	if(0 == health):
		get_parent().die()


func heal(hp : int): # Adds health using the hp parameter
	health = health + hp
	health_changed.emit(health)
	

func get_health(): # Returns the health
	return health
	

func set_health(hp : int): # Sets the health to the hp parameter
	health = hp
	health_changed.emit(health)
	

func set_max_health(hp : int): # Sets the max health to the hp parameter
	max_health = hp
	

func get_max_health(): # Returns the max health
	return max_health
	
	
func save():
	var children_data = []
	for child in get_children():
		if child.has_method("save"):
			children_data.append(child.save())  # Recursively save child nodes
	var save_dict = {
		"scene" : get_scene_file_path(),
		"properties" : {
			"health" : health,
			"max_health" : max_health
		},
		"unique" : true
	}
	return save_dict
