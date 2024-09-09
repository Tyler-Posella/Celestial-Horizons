extends Node2D
class_name HealthComponent

# Variables
@export var max_health : int
@onready var health : int = max_health

# Signals
signal healthChanged(count : int)

# Functions
func _ready():
	healthChanged.emit(health)
	
	
func damage(dmg : int):
	health = health - dmg
	healthChanged.emit(health)
	if(0 == health):
		get_parent().die()


func heal(hp : int):
	health = health + hp
	
	
func getHealth():
	return health
	
	
func setHealth(hp : int):
	health = hp
	
	
func setMaxHealth(hp : int):
	max_health = hp
	
	
func getMaxHealth():
	return max_health
