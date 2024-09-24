class_name HealthComponent
extends Node2D


# Signals
signal health_changed(count : int)

# Export Variables
@export var max_health : int

# Variables
var health : int = max_health

# Functions
func _ready():
	health_changed.emit(health)
	

func damage(dmg : int): # Lowers the health by the damage parameter
	health = health - dmg
	health_changed.emit(health)
	if(0 == health):
		get_parent().die()


func heal(hp : int): # Adds health using the hp parameter
	health = health + hp
	

func get_health(): # Returns the health
	return health
	

func set_health(hp : int): # Sets the health to the hp parameter
	health = hp
	

func set_max_health(hp : int): # Sets the max health to the hp parameter
	max_health = hp
	
# Returns the max health
func get_max_health():
	return max_health
