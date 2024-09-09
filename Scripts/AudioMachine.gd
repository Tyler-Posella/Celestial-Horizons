extends Node2D

# Variables
@onready var ambience_player = $AmbienceAudioStream
@onready var music_player = $MusicAudioStream
@onready var stream_1 = $AudioStream1
@onready var stream_2 = $AudioStream2
@onready var stream_3 = $AudioStream3
@onready var stream_4 = $AudioStream4
@onready var stream_5 = $AudioStream5
@onready var stream_6 = $AudioStream6
@onready var stream_7 = $AudioStream7
@onready var stream_8 = $AudioStream8
var stream_array = []

# Functions
func _ready():
	stream_array.append(stream_1)
	stream_array.append(stream_2)
	stream_array.append(stream_3)
	stream_array.append(stream_4)
	stream_array.append(stream_5)
	stream_array.append(stream_6)
	stream_array.append(stream_7)
	stream_array.append(stream_8)
	
	
func playSound(path : String):
	var player = getOpenPlayer()
	if(player == null):
		pass
	else:
		player.stream = load(path)
		player.play()
	
	
func getOpenPlayer():
	for i in stream_array.size():
		if(stream_array[i].is_playing() == false):
			return stream_array[i]
			break
	
	
func getMusicPlayer():
	return music_player
	
	
func muteMusicPlayer():
	music_player.volume_db = -80
	
	
func unmuteMusicPlayer():
	music_player.volume_db = 0
	
	
func getAmbiencePlayer():
	return ambience_player
	
