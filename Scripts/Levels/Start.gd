extends Node2D

func _ready():
	Utils.getGameAudio().getMusicPlayer().stream = load("res://Audio/Music/Spring.wav")
	Utils.getGameAudio().getMusicPlayer().play()
	pass
