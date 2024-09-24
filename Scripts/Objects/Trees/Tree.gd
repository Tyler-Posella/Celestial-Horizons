class_name TreeInteractable
extends Node2D

# Constant Variables
const STUMP_SCENE = preload("res://Scenes/Objects/Trees/Stump.tscn")
const COLLECTABLE_SCENE = preload("res://Scenes/Objects/Collectable.tscn")
const LOG_RESOURCE = preload("res://Resoures/Harvestables/Tree/Log.tres")
const BRANCH_RESOURCE = preload("res://Resoures/Harvestables/Tree/Branch.tres")
const TWIG_RESOURCE = preload("res://Resoures/Harvestables/Tree/Twig.tres")

# Export Variables
@export var health_component : HealthComponent
@export var growable_component : GrowableComponent
@export var audio_component : AudioMachine
@export var tree_texture : Texture
@export var growable : Item

# Variables
var player_present : bool = false
var markers = []

# Onready Variables
@onready var health = $HealthComponent
@onready var sprite = $TreeSprite
@onready var animation_tree = $AnimationTree
@onready var state_machine = animation_tree.get("parameters/playback")

# Functions

func _ready(): # Initializes the default values and configures the markers and arrays
	$TreeSprite.texture = tree_texture
	$FallSprite.hide()
	health_component.set_health(3)
	if(growable != null):
		growable_component.set_growable_item(growable)
		markers.append($Marker1)
		markers.append($Marker2)
		markers.append($Marker3)
		set_markers()
	
	
func _process(delta): # Checks if the player is interacting inside the radius 
	if(Input.is_action_just_pressed("interact") and player_present):
		shake()


func set_markers(): # Sets the markers to the proper positions for each fruit
	if(growable.get_name() == "Apple"):
		markers[0].position = Vector2(-20, -5)
		markers[1].position = Vector2(16, -1)
		markers[2].position = Vector2(19, -9)
	if(growable.get_name() == "Pear"):
		markers[0].position = Vector2(-21, -7)
		markers[1].position = Vector2(15, 0)
		markers[2].position = Vector2(-19, 3)
	if(growable.get_name() == "Peach"):
		markers[0].position = Vector2(-19, -6)
		markers[1].position = Vector2(16, -1)
		markers[2].position = Vector2(-16, 3)
	if(growable.get_name() == "Orange"):
		markers[0].position = Vector2(-20, -6)
		markers[1].position = Vector2(16, -1)
		markers[2].position = Vector2(-17, 3)
		
	
func die(): # Kills the tree
	$TreeSprite.hide()
	$FallSprite.show()
	state_machine.travel("fall")
	audio_component.play_sound("res://Audio/SFX/Tree/TreeFall.wav")
	
	
func shake(): # Shakes the tre
	state_machine.travel("shake_long")
	audio_component.play_sound("res://Audio/SFX/Tree/TreeShake.wav")


func _on_animation_tree_animation_finished(anim_name): # On animation finish, do the appropriate action
	if(anim_name == "fall"):
		var stump = STUMP_SCENE.instantiate()
		stump.global_position = global_position
		get_parent().add_child(stump)
		drop_items()
		queue_free()
	if(anim_name == "shake_long"):
		growable_component.harvest()


func drop_items(): # Drops items from the tree
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
			dropped_item.set_item(growable_component.get_growable_item())
			dropped_item.global_position = global_position
			get_parent().add_child(dropped_item)
				

func _on_chop_area_area_entered(area): # On axe hitbox entered tree hitbox	
	health_component.damage(1)
	if(health_component.get_health() > 0):
		state_machine.travel("shake_short")
	audio_component.play_sound("res://Audio/SFX/Tree/TreeHit.wav")
	

func get_base_texture(): # Returns the trees texture
	return tree_texture


func _on_interaction_component_body_entered(body): # On player entry, set player present to true
	if(body.is_in_group("Player")):
		player_present = true


func _on_interaction_component_body_exited(body): # On player exit, set player present to false
	if(body.is_in_group("Player")):
		player_present = false
