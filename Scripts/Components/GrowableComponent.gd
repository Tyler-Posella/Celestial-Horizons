class_name GrowableComponent
extends Node2D

# Signals
signal harvested()
signal grown()
signal stage_advanced()

# Constants
const COLLECTABLE_SCENE = preload("res://Scenes/Objects/Collectable.tscn")

# Variables
var growable : GrowableRes
var growtime : int = 0
var age : int = 0
var has_grown : bool = false

# Onready Variables
@onready var growth_timer = $GrowthTimer
@onready var marker_array = []

# Functions
func _ready():
	SignalManager.add_listener("advance_day", self, "_on_day_pass")
	
func is_grown(): # Returns true if the growable is grown
	if(has_grown):
		return true
	else:
		return false
		

func harvest(): # Harvests the growable
	if(is_grown()):
		harvested.emit()
		has_grown = false
	

func drop_collectables(item : ItemRes): # Drops the collectables from the growwable into the level scene
	for i in 3:
		var collectable = COLLECTABLE_SCENE.instantiate()
		collectable.item = item
		get_parent().get_parent().add_child(collectable)
		#Instantiate into scene
	
func _on_day_pass():
	if(age == growable.get_growtime()):
		pass
	else:
		age = age + 1
		stage_advanced.emit()
		if(age == growable.get_growtime()):
			_on_finished_growing()
	
	
func _on_finished_growing(): # On growth timer timout, grow the growable
	grown.emit()
	has_grown = true
	

func get_growable(): # Get the item on the growable component
	return growable
	
	
func set_growable(new_growable : GrowableRes):
	growable = new_growable
	growtime = growable.get_growtime()
