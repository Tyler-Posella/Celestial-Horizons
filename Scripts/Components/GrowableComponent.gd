extends Node2D
class_name GrowableComponent
#Constant variables 
const collectable_scene = preload("res://Scenes/Objects/Collectable.tscn")
#Export variables
var growable : Item
#Variables
var has_grown : bool = false
#Onready variables
@onready var growth_timer = $GrowthTimer
@onready var marker_array = []

func _ready():
	growable = get_parent().growable
	if(growable != null):
		growth_timer.start()
	
func isGrown():
	if(has_grown):
		return true
	else:
		return false
		
func harvest():
	if(isGrown()):
		#Utils.getGameInventory().addItem(growable, 3)
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
	
func dropCollectables(item : Item):
	for i in 3:
		var collectable = collectable_scene.instantiate()
		collectable.item = item
		get_parent().add_child(collectable)
		#Instantiate into scene
	
func grow():
	has_grown = true
	get_parent().sprite.texture = growable.getGrownTexture()

func _on_growth_timer_timeout():
	grow()
	
func getGrowableItem():
	return growable
	
func setGrowableItem(obj : Item):
	growable = obj
