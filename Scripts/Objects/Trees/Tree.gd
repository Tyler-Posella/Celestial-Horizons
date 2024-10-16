class_name TreeObject
extends Node2D

# Constant Variables
const STUMP_SCENE = preload("res://Scenes/Objects/Trees/TreeStump.tscn")
const COLLECTABLE_SCENE = preload("res://Scenes/Objects/Collectable.tscn")
const LOG_RESOURCE = preload("res://Resoures/Items/Trees/Log.tres")
const BRANCH_RESOURCE = preload("res://Resoures/Items/Trees/Branch.tres")
const TWIG_RESOURCE = preload("res://Resoures/Items/Trees/Twig.tres")

# Export Variables
@export var type : TreeRes = load("res://Resoures/Trees/DefaultTree.tres")

# Variables
var markers = []

# Onready Variables
@onready var growable_component = $GrowableComponent
@onready var harvest_component = $HarvestComponent
@onready var interaction_component = $InteractionComponent
@onready var audio_component = $AudioMachine
@onready var animation_tree = $AnimationTree
@onready var state_machine = animation_tree.get("parameters/playback")

# Functions
func _ready(): # Initializes the default values and configures the markers and arrays
	# Set TreeRes data
	if(type is GrowableTreeRes):
		growable_component.set_growable(type.get_fruit())
		$FallSprite.texture = type.get_fall_texture()
		$TreeSprite.texture = type.get_default_texture()
		markers.append($Marker1)
		markers.append($Marker2)
		markers.append($Marker3)
		set_markers()
	else:
		$FallSprite.texture = type.get_fall_texture()
		$TreeSprite.texture = type.get_default_texture()
	harvest_component.set_hitpoints(type.get_hitpoints())
	$FallSprite.hide()
	

func set_markers() -> void: # Sets the markers to the proper positions for each fruit
	if(type.get_fruit().get_item_name() == "Passionate Pome"):
		markers[0].position = Vector2(-20, -5)
		markers[1].position = Vector2(16, -1)
		markers[2].position = Vector2(19, -9)
	if(type.get_fruit().get_item_name() == "Suede Paio"):
		markers[0].position = Vector2(-21, -7)
		markers[1].position = Vector2(15, 0)
		markers[2].position = Vector2(-19, 3)
	if(type.get_fruit().get_item_name() == "Prime Drupe"):
		markers[0].position = Vector2(-19, -6)
		markers[1].position = Vector2(16, -1)
		markers[2].position = Vector2(-16, 3)
	if(type.get_fruit().get_item_name() == "Orange"):
		markers[0].position = Vector2(-20, -6)
		markers[1].position = Vector2(16, -1)
		markers[2].position = Vector2(-17, 3)
		
	
func _on_harvest_component_died() -> void:
	$TreeSprite.hide()
	$FallSprite.show()
	state_machine.travel("fall")
	audio_component.play_sound("res://Audio/SFX/Tree/TreeFall.wav")
	
	
func shake(): # Shakes the tre
	state_machine.travel("shake_long")
	audio_component.play_sound("res://Audio/SFX/Tree/TreeShake.wav")


func _on_animation_tree_animation_finished(anim_name) -> void: # On animation finish, do the appropriate action
	if(anim_name == "fall"):
		var stump = STUMP_SCENE.instantiate()
		stump.global_position = global_position
		get_parent().add_child(stump)
		drop_items()
		queue_free()
	if(anim_name == "shake_long"):
		growable_component.harvest()


func drop_items() -> void: # Drops items from the tree
	#Note: Eventually replace marker location drops with randomized item dropping on tree death
	var dropped_item
	var rng = RandomNumberGenerator.new()
	#Random amount of logs
	for i in rng.randi_range(1,2):
		dropped_item = COLLECTABLE_SCENE.instantiate()
		dropped_item.set_item(LOG_RESOURCE)
		dropped_item.global_position = $Marker1.global_position
		get_parent().add_child(dropped_item)
	#Random amount of branches
	for i in rng.randi_range(1,3):
		dropped_item = COLLECTABLE_SCENE.instantiate()
		dropped_item.set_item(BRANCH_RESOURCE)
		dropped_item.global_position = $Marker2.global_position
		get_parent().add_child(dropped_item)
	#Random amount of twigs
	for i in rng.randi_range(2,3):
		dropped_item = COLLECTABLE_SCENE.instantiate()
		dropped_item.set_item(TWIG_RESOURCE)
		dropped_item.global_position = $Marker3.global_position
		get_parent().add_child(dropped_item)
	#Drops fruit if grown
	if(growable_component.is_grown()):
		for i in 3:
			dropped_item = COLLECTABLE_SCENE.instantiate()
			dropped_item.set_item(growable_component.get_growable())
			dropped_item.global_position = global_position
			get_parent().add_child(dropped_item)


func _on_growable_component_harvested() -> void:
	for i in 3:
		var collectable = COLLECTABLE_SCENE.instantiate()
		collectable.item = type.get_fruit()
		collectable.global_position = markers[i].global_position
		get_parent().add_child(collectable)
		$TreeSprite.texture = type.get_default_texture()

		
func _on_growable_component_grown() -> void:
	$TreeSprite.texture = type.get_fruity_texture()


func _on_harvest_component_hit() -> void:
	if(harvest_component.get_hitpoints() > 0):
		state_machine.travel("shake_short")
	audio_component.play_sound("res://Audio/SFX/Tree/TreeHit.wav")


func _on_interactable_component_interacted():
	shake()
