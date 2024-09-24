extends Node

# Variables
var player
var inventory
var ui
var music_player
var audio_player
var level

# Functions
func get_level_node():
	return get_tree().get_first_node_in_group("LevelNode")
	
	
func get_level():
	return level
	
	
func set_level(obj):
	level = obj
	
	
func get_game_player():
	return get_tree().get_first_node_in_group("PlayerNode")
	
	
func get_player():
	return player
	
	
func set_player(obj):
	player = obj


func get_inventory_node():
	return get_tree().get_first_node_in_group("PlayerInventory")
	
	
func get_inventory():
	return inventory
	
	
func set_inventory(obj):
	inventory = obj


func get_ui_node():
	return get_tree().get_first_node_in_group("UINode")
	
	
func get_ui():
	return ui
	
	
func set_ui(obj):
	ui = obj
	
	
func get_game_audio():
	return get_tree().get_first_node_in_group("GameAudio")
	


	
