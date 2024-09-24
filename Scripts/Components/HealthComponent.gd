extends Node2D
class_name HealthComponent

# Export Variables
@export var max_health : int

# Instance Variables
var health : int = max_health

# Signals
signal healthChanged(count : int)

# Functions
func _ready():
	healthChanged.emit(health)
	
# Lowers the health by the damage parameter
func damage(dmg : int):
	health = health - dmg
	healthChanged.emit(health)
	if(0 == health):
		get_parent().die()

# Adds health using the hp parameter
func heal(hp : int):
	health = health + hp
	
# Returns the health
func getHealth():
	return health
	
# Sets the health to the hp parameter
func setHealth(hp : int):
	health = hp
	
# Sets the max health to the hp parameter
func setMaxHealth(hp : int):
	max_health = hp
	
# Returns the max health
func getMaxHealth():
	return max_health
