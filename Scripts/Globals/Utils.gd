extends Node

var player
var inventory
var ui
var music_player
var audio_player
var level

func getGameLevel():
	return get_tree().get_first_node_in_group("LevelNode")
	
func getLevel():
	return level
	
func setLevel(obj):
	level = obj
	
func getGamePlayer():
	return get_tree().get_first_node_in_group("PlayerNode")
	
func getPlayer():
	return player
	
func setPlayer(obj):
	player = obj

func getGameInventory():
	return get_tree().get_first_node_in_group("PlayerInventory")
	
func getInventory():
	return inventory
	
func setInventory(obj):
	inventory = obj

func getGameUi():
	return get_tree().get_first_node_in_group("UINode")
	
func getUI():
	return ui
	
func setUI(obj):
	ui = obj
	
func getGameAudio():
	return get_tree().get_first_node_in_group("GameAudio")
	

	
