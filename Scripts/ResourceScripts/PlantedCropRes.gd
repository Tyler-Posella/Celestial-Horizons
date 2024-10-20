class_name PlantedCropRes
extends GrowableRes

# Constant Variables
const crop_texture : Texture = preload("res://Assets/Items/Complete-Sheet.png")

# Export Variables
@export var height : int = 1
@export var texture_row : int
@export var grow_seasons : Array = [0, 0, 0, 0]
@export var harvest_item : ItemRes

# Functions
func get_crop_texture():
	return crop_texture
	

func get_crop_height():
	return height
	
	
func get_texture_row():
	return texture_row
	
	
func get_growtime():
	return growtime
	
	
func get_grow_seasons():
	return grow_seasons
	
	
func grows_in_season(season_number : int):
	if(season_number == 0):
		return grow_seasons[0]
	elif(season_number == 1):
		return grow_seasons[1]
	elif(season_number == 2):
		return grow_seasons[2]
	elif(season_number == 3):
		return grow_seasons[3]
		
		
func get_harvest_item():
	return harvest_item
