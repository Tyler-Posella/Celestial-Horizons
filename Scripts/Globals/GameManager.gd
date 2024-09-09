extends Node


func loadMainMenu():
	var menu = preload("res://Scenes/UI/Menus/MainMenu/MainMenu.tscn")
	var main_menu = menu.instantiate()
	Utils.getGameUi().add_child(main_menu)
	get_tree().get_first_node_in_group("UINode").get_node("MainMenu").get_node("ButtonGrid").get_node("StartButton").pressed.connect(_on_game_start)
	get_tree().get_first_node_in_group("UINode").get_node("MainMenu").get_node("ButtonGrid").get_node("LoadButton").pressed.connect(_on_game_load)
	get_tree().get_first_node_in_group("UINode").get_node("MainMenu").get_node("ButtonGrid").get_node("OptionsButton").pressed.connect(_on_game_options)
	get_tree().get_first_node_in_group("UINode").get_node("MainMenu").get_node("ButtonGrid").get_node("QuitButton").pressed.connect(_on_game_quit)


func loadAudioMachine():
	pass


func loadLevel():
	#Instantiate start level
	var level_scene = preload("res://Scenes/Levels/Start.tscn")
	var level = level_scene.instantiate()
	Utils.setLevel(level)
	Utils.getGameLevel().add_child(level)
	#Instantiate player
	var player_scene = preload("res://Scenes/Objects/Player.tscn")
	var player = player_scene.instantiate()
	Utils.setPlayer(player)
	get_tree().get_first_node_in_group("PlayerNode").add_child(player)
	#Remove menu inventory
	get_tree().get_first_node_in_group("UINode").get_node("MainMenu").queue_free()
	#Add player ui
	var ui_scene = preload("res://Scenes/UI/GameUI/PlayerUI.tscn")
	var ui =  ui_scene.instantiate()
	Utils.setUI(ui)
	get_tree().get_first_node_in_group("UINode").add_child(ui)
	
	
func _on_game_start():
	loadLevel()
	
	
func _on_game_load():
	print("Load")


func _on_game_options():
	print("Options")
	
	
func _on_game_quit():
	get_tree().quit()


func returnToMenu():
	unloadGame()
	loadMainMenu()
	
	
func unloadGame():
	get_tree().get_first_node_in_group("UI").queue_free()
	get_tree().get_first_node_in_group("Level").queue_free()
	get_tree().get_first_node_in_group("Player").queue_free()
	Utils.getGameAudio().getMusicPlayer().stop()
