extends Node2D
class_name GrowableComponent

# Constant variables 
const collectable_scene = preload("res://Scenes/Objects/Collectable.tscn")

# Scene Variables
@onready var growth_timer = $GrowthTimer
@onready var marker_array = []

# Instance Variables
var growable : Item
var has_grown : bool = false

# Functions
func _ready():
	growable = get_parent().growable
	if(growable != null):
		growth_timer.start()
	
# Returns true if the growable is grown
func isGrown():
	if(has_grown):
		return true
	else:
		return false
		
# Harvests the growable
func harvest():
	if(isGrown()):
		for i in 3:
			var collectable = collectable_scene.instantiate()
			collectable.item = growable
			collectable.global_position = get_parent().markers[i].global_position
			get_parent().get_parent().add_child(collectable)
		get_parent().sprite.texture = get_parent().getBaseTexture()
		growth_timer.start()
		has_grown = false
	else:
		pass
	
# Drops the collectables from the growwable into the level scene
func dropCollectables(item : Item):
	for i in 3:
		var collectable = collectable_scene.instantiate()
		collectable.item = item
		get_parent().get_parent().add_child(collectable)
		#Instantiate into scene
	
# Changes the state of the growable into its grown state
func grow():
	has_grown = true
	get_parent().sprite.texture = growable.getGrownTexture()

# On growth timer timout, grow the growable
func _on_growth_timer_timeout():
	grow()
	
# Get the item on the growable component
func getGrowableItem():
	return growable
	
# Set the item for the growable component
func setGrowableItem(obj : Item):
	growable = obj
