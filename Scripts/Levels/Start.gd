extends Node2D

# Functions
func _ready():
	Utils.getGameAudio().getMusicPlayer().stream = load("res://Audio/Music/Spring.wav")
	Utils.getGameAudio().getMusicPlayer().play()
	pass
