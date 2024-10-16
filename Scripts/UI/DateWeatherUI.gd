class_name DateWeatherUI
extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalManager.add_listener("advance_day", self, "_on_date_incremented")

func _on_date_incremented():
	var day_part : String = "Day " + str(Game.get_date_time().get_day())
	var season_part : String = get_season_string()
	var year_part : String = "Year " + str(Game.get_date_time().get_year())
	$PanelContainer/Label.set_text(day_part + " - " + season_part + " - " + year_part)
	
	
func get_season_string():
	var season_num = DateTimeManager.get_season()
	if(season_num == 1):
		return "Spring"
	elif(season_num == 2):
		return "Summer"
	elif(season_num == 3):
		return "Autumn"
	elif(season_num == 4):
		return "Winter"
	else:
		return "ERROR"
		
