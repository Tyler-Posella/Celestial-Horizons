extends Node2D
class_name CurrencyComponent

# Instance Variables
var coin_count : int = 0

# Signals
signal coinsChanged(count : int)

# Functions
# Returns the coin count
func getCoinCount():
	return coin_count

# Sets the coin count
func setCoinCount(count : int):
	coin_count = count
	coinsChanged.emit(coin_count)
	
# Adds a flat number of coins to the existing coin count
func addCoins(count : int):
	coin_count = coin_count + count
	Utils.getGameAudio().playSound("res://Audio/SFX/Inventory/CoinPickup.wav")
	coinsChanged.emit(coin_count)
	

func save():
	var children_data = []
	for child in get_children():
		if child.has_method("save"):
			children_data.append(child.save())  # Recursively save child nodes
	var save_dict = {
		"scene" : get_scene_file_path(),
		"properties" : {
			"coin_count" : coin_count
		},
		"children": children_data
	}
	return save_dict

	
