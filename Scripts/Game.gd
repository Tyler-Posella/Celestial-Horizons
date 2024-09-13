extends Node2D
class_name BaseGame

# Variables
@onready var ui_node = $GUI
@onready var level_node = $GameLevel
@onready var player_node = $GamePlayer
@onready var audio_node = $GameAudio

# Functions
func _ready():
	GameManager.start()
	
	
	
	
