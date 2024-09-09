extends Control
class_name MainMenu
#Constants
const menu_button = preload("res://Scenes/UI/Menus/MenuButton.tscn")
const music = preload("res://Audio/Music/Menu.wav")

#Functions
func _ready():
	Utils.getGameAudio().getMusicPlayer().stream = load("res://Audio/Music/Menu.wav")
	Utils.getGameAudio().getMusicPlayer().play()
	
