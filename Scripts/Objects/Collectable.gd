class_name Collectable
extends RigidBody2D

# Export Variables
@export var item : ItemRes

# Variables
var time : float = 0.0
var amplitude = 1.0
var frequency = 2.5

# Onready Variables
@onready var sprite : Sprite2D = $Sprite2D
@onready var texture : Texture = sprite.texture
@onready var default_pos = sprite.position

# Functions
func _ready():
	sprite.texture = item.get_texture()


func _physics_process(delta : float): # Plays the animation to move the items while sitting on the ground
	time += delta * frequency
	sprite.position = (default_pos + Vector2(0, sin(time * frequency	) * amplitude))


func delete_item(): # Deletes the item
	queue_free()
	

func set_item(new_item : ItemRes): # Sets the collectables item type
	item = new_item
	

func get_item(): # Returns the collectables item type
	return item


func _on_interaction_component_body_entered(body): # On interaction body entering the interaction radius, do the appropriate action
	if(body.is_in_group("Player")):
		if(item is CoinRes):
			Game.get_player().get_currency_component().add_coins(item.coin_value)
			delete_item()
		elif(item is ItemRes):
			Game.get_player().get_inventory_component().pickup_item(item)
			delete_item()
		
