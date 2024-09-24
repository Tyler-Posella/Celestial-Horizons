class_name BaseGame
extends Node2D

# Onready Variables
@onready var ui_node = $GUI
@onready var level_node = $GameLevel
@onready var player_node = $GamePlayer
@onready var audio_node = $GameAudio

# Functions
func _ready():
	GameManager.start()
	
	
	
	
