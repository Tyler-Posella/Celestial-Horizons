class_name GrowableComponent
extends Node2D

# Constants
const COLLECTABLE_SCENE = preload("res://Scenes/Objects/Collectable.tscn")

# Variables
var growable : Item
var has_grown : bool = false

# Onready Variables
@onready var growth_timer = $GrowthTimer
@onready var marker_array = []

# Functions
func _ready():
	growable = get_parent().growable
	if(growable != null):
		growth_timer.start()
	

func is_grown(): # Returns true if the growable is grown
	if(has_grown):
		return true
	else:
		return false
		

func harvest(): # Harvests the growable
	if(is_grown()):
		for i in 3:
			var collectable = COLLECTABLE_SCENE.instantiate()
			collectable.item = growable
			collectable.global_position = get_parent().markers[i].global_position
			get_parent().get_parent().add_child(collectable)
		get_parent().sprite.texture = get_parent().get_base_texture()
		growth_timer.start()
		has_grown = false
	else:
		pass
	

func drop_collectables(item : Item): # Drops the collectables from the growwable into the level scene
	for i in 3:
		var collectable = COLLECTABLE_SCENE.instantiate()
		collectable.item = item
		get_parent().get_parent().add_child(collectable)
		#Instantiate into scene
	

func grow(): # Changes the state of the growable into its grown state
	has_grown = true
	get_parent().sprite.texture = growable.get_grown_texture()


func _on_growth_timer_timeout(): # On growth timer timout, grow the growable
	grow()
	

func get_growable_item(): # Get the item on the growable component
	return growable
	

func set_growable_item(obj : Item): # Set the item for the growable component
	growable = obj
