extends Control
class_name MainMenu
#Constants
const menu_button = preload("res://Scenes/UI/MenuButton.tscn")
const music = preload("res://Audio/Music/Menu.wav")
#Node variables
#Instance variables
#Signals

#Functions
func _ready():
	Utils.getGameAudio().getMusicPlayer().stream = load("res://Audio/Music/Menu.wav")
	Utils.getGameAudio().getMusicPlayer().play()
	
