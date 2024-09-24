class_name AudioMachine
extends Node2D

# Constants
const SELF_SCENE = preload("res://Scenes/Audio/AudioMachine.tscn")

# Variables
var stream_array = []

# Functions	
# Creates 8 new AudioStreamPlayer2D, adds them to array to be accessed
func _ready():
	for i in 8:
		var new_audio_player = AudioStreamPlayer2D.new()
		stream_array.append(new_audio_player)
		add_child(new_audio_player)
	
# Plays a sound
func play_sound(path : String):
	var player = get_open_player()
	if(player == null):
		pass
	else:
		player.stream = load(path)
		player.play()
	
# Finds the first avaliabile AudioStreamPlayer2D that is not currently being used
func get_open_player():
	for i in stream_array.size():
		if(stream_array[i].is_playing() == false):
			return stream_array[i]
			break
