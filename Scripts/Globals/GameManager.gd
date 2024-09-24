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


func loadLevel(new_level):
	get_tree().get_first_node_in_group("UI").queue_free()
	get_tree().get_first_node_in_group("LevelNode").add_child(new_level)
	Utils.setLevel(new_level)
	
func loadPlayer(new_player):
	get_tree().get_first_node_in_group("PlayerNode").add_child(new_player)
	Utils.setPlayer(new_player)
	
func _on_game_start():
	#Instantiate start level
	var level_scene = preload("res://Scenes/Levels/Start.tscn")
	var level = level_scene.instantiate()
	get_tree().get_first_node_in_group("LevelNode").add_child(level)
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
	
	
func _on_game_load():
	# Step 1: Load all of the levels
	# Step 2: Load the level the game left off on
	var current_level = load("/Users/tylerposella/Desktop/Nekowind-Adventures/LocalData/StartLevel.json")
	GameManager.loadLevel(current_level)
	# Step 3: Load the contents of the level dynamically, and include saved data if it is needed
	# Step 4: Load the player onto the current level
	var current_player = SaveManager.load_node("/Users/tylerposella/Desktop/Nekowind-Adventures/LocalData/PlayerData.json")
	print(current_player.position)
	#var current_player = SaveManager.load_node("/Users/tylerposella/Desktop/Nekowind-Adventures/LocalData/PlayerData.json")
	#GameManager.loadPlayer(current_player)
	# Step 5: Only load the UI after the entire scene for the first level is completed
	#var current_ui_scene = load("res://Scenes/UI/GameUI/PlayerUI.tscn")
	#var current_ui = current_ui_scene.instantiate()
	#get_tree().get_first_node_in_group("UINode").add_child(current_ui)
	#Utils.setUI(current_ui)

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
	
	
func start():
	loadMainMenu()
