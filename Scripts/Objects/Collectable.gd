extends RigidBody2D
class_name Collectable

# Export Variables
@export var item : Item

# Scene Variables
@onready var sprite : Sprite2D = $Sprite2D
@onready var texture : Texture = sprite.texture
@onready var default_pos = sprite.position

# Instance Variables
var time : float = 0.0
var amplitude = 1.0
var frequency = 2.5

# Functions
func _ready():
	sprite.texture = item.getTexture()

# Plays the animation to move the items while sitting on the ground
func _physics_process(delta : float):
	time += delta * frequency
	sprite.position = (default_pos + Vector2(0, sin(time * frequency	) * amplitude))

# Deletes the item
func deleteItem():
	queue_free()
	
# Sets the collectables item type
func setItem(itm):
	item = itm
	
# Returns the collectables item type
func getItem():
	return item

# On interaction body entering the interaction radius, do the appropriate action
func _on_interaction_component_body_entered(body):
	if(body.is_in_group("Player")):
		if(item is Coin):
			Utils.getPlayer().getCurrencyComponent().addCoins(item.coin_value)
			deleteItem()
		elif(item is Item):
			Utils.getPlayer().getInventoryComponent().pickupItem(item)
			deleteItem()
		
