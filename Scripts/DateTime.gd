extends Node

# Signals
signal day_incremented()

# Variables
var current_day: int = 1
var current_season : int = 1
var current_year: int = 1

# Functions	
func _ready():
	SignalManager.add_listener("advance_day", self, "_on_day_finished")
	
	
func _on_day_finished():
	if(current_day == 30):
		current_day = 1
		if(current_season == 4):
			current_season = 1
		else:
			current_season = current_season + 1
	else:
		current_day = current_day + 1
	day_incremented.emit()
	
func get_day():
	return current_day


func get_season():
	return current_season


func get_year():
	return current_year
	
	
func save():
	pass
