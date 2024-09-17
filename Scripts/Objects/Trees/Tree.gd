extends Node2D
class_name TreeInteractable

# Constant Variables
const stump_scene = preload("res://Scenes/Objects/Trees/Stump.tscn")
const collectable_scene = preload("res://Scenes/Objects/Collectable.tscn")
const log_resource = preload("res://Resoures/Harvestables/Tree/Log.tres")
const branch_resource = preload("res://Resoures/Harvestables/Tree/Branch.tres")
const twig_resource = preload("res://Resoures/Harvestables/Tree/Twig.tres")

# Export Variables
@export var health_component : HealthComponent
@export var growable_component : GrowableComponent
@export var audio_component : AudioMachine
@export var tree_texture : Texture
@export var growable : Item

# Variables
var player_present : bool = false
var markers = []
@onready var health = $HealthComponent
@onready var sprite = $TreeSprite
@onready var animation_tree = $AnimationTree
@onready var state_machine = animation_tree.get("parameters/playback")

# Functions
func _ready():
	$TreeSprite.texture = tree_texture
	$FallSprite.hide()
	health_component.setHealth(3)
	if(growable != null):
		growable_component.setGrowableItem(growable)
		markers.append($Marker1)
		markers.append($Marker2)
		markers.append($Marker3)
		setMarkers()
	
	
func _process(delta):
	if(Input.is_action_just_pressed("interact") and player_present):
		shake()


func setMarkers():
	if(growable.getName() == "Apple"):
		markers[0].position = Vector2(-20, -5)
		markers[1].position = Vector2(16, -1)
		markers[2].position = Vector2(19, -9)
	if(growable.getName() == "Pear"):
		markers[0].position = Vector2(-21, -7)
		markers[1].position = Vector2(15, 0)
		markers[2].position = Vector2(-19, 3)
	if(growable.getName() == "Peach"):
		markers[0].position = Vector2(-19, -6)
		markers[1].position = Vector2(16, -1)
		markers[2].position = Vector2(-16, 3)
	if(growable.getName() == "Orange"):
		markers[0].position = Vector2(-20, -6)
		markers[1].position = Vector2(16, -1)
		markers[2].position = Vector2(-17, 3)
		
		
func die():
	$TreeSprite.hide()
	$FallSprite.show()
	state_machine.travel("fall")
	audio_component.playSound("res://Audio/SFX/Tree/TreeFall.wav")
	
	
func shake():
	state_machine.travel("shake_long")
	audio_component.playSound("res://Audio/SFX/Tree/TreeShake.wav")


func _on_animation_tree_animation_finished(anim_name):
	if(anim_name == "fall"):
		var stump = stump_scene.instantiate()
		stump.global_position = global_position
		get_parent().add_child(stump)
		dropItems()
		queue_free()
	if(anim_name == "shake_long"):
		growable_component.harvest()


func dropItems():
	#Note: Eventually replace marker location drops with randomized item dropping on tree death
	var dropped_item
	var rng = RandomNumberGenerator.new()
	#Random amount of logs
	for i in rng.randi_range(1,2):
		dropped_item = collectable_scene.instantiate()
		dropped_item.setItem(log_resource)
		dropped_item.global_position = $Marker1.global_position
		get_parent().add_child(dropped_item)
	#Random amount of branches
	for i in rng.randi_range(1,3):
		dropped_item = collectable_scene.instantiate()
		dropped_item.setItem(branch_resource)
		dropped_item.global_position = $Marker2.global_position
		get_parent().add_child(dropped_item)
	#Random amount of twigs
	for i in rng.randi_range(2,3):
		dropped_item = collectable_scene.instantiate()
		dropped_item.setItem(twig_resource)
		dropped_item.global_position = $Marker3.global_position
		get_parent().add_child(dropped_item)
	#Drops fruit if grown
	if(growable_component.isGrown()):
		for i in 3:
			dropped_item = collectable_scene.instantiate()
			dropped_item.setItem(growable_component.getGrowableItem())
			dropped_item.global_position = global_position
			get_parent().add_child(dropped_item)
				
				
func _on_chop_area_area_entered(area):
	health_component.damage(1)
	if(health_component.getHealth() > 0):
		state_machine.travel("shake_short")
	audio_component.playSound("res://Audio/SFX/Tree/TreeHit.wav")
	
	
func getBaseTexture():
	return tree_texture


func _on_interaction_component_body_entered(body):
	if(body.is_in_group("Player")):
		player_present = true


func _on_interaction_component_body_exited(body):
	if(body.is_in_group("Player")):
		player_present = false
