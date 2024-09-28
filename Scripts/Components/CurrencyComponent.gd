class_name CurrencyComponent
extends Node2D

# Signals
signal coins_changed(count : int)
signal sound_emitted(sound)

# Variables
var coin_count : int = 0
# Functions

func get_coin_count(): # Returns the coin count
	return coin_count


func set_coin_count(count : int): # Sets the coin count
	coin_count = count
	coins_changed.emit(coin_count)
	

func add_coins(count : int): # Adds a flat number of coins to the existing coin count
	coin_count = coin_count + count
	sound_emitted.emit("res://Audio/SFX/Inventory/CoinPickup.wav")
	coins_changed.emit(coin_count)
	

func save():
	var save_dict = {
		"scene" : get_scene_file_path(),
		"properties" : {
			"coin_count" : coin_count
		},
		"unique" : true
	}
	return save_dict

	
