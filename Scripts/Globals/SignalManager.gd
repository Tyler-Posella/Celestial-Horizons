extends Node

var bed_slept : Signal
var day_increemented : Signal


func set_bed_slept(new_signal : Signal):
	bed_slept = new_signal
	

func get_bed_slept():
	return bed_slept
	
	
func set_day_incremented(new_signal : Signal):
	day_increemented = new_signal
	
	
func get_day_incremented():
	return day_increemented
