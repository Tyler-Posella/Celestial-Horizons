extends RigidBody2D
class_name Collectable

@onready var pickupable : bool = true
@onready var sprite : Sprite2D = $Sprite2D
@onready var texture : Texture = sprite.texture
@onready var time : float = 0.0
@export var item : Item
@onready var amplitude = 1.0
@onready var frequency = 2.5
@onready var default_pos = sprite.position

func _ready():
	sprite.texture = item.getTexture()

func _physics_process(delta : float):
	time += delta * frequency
	getSprite().set_position(default_pos + Vector2(0, sin(time * frequency	) * amplitude))

func deleteItem():
	queue_free()
	
func setPickupable(set):
	pickupable = set

func getPickupable():
	return pickupable
	
func setSprite(sprt):
	sprite = sprt
	
func getSprite():
	return sprite
	
func setItem(itm):
	item = itm
	
func getItem():
	return item
	
func setTexture(txt):
	$Sprite2D.texture = item.texture
	
func getTexture():
	return texture
	
func setTime(num : float):
	time = num
	
func getTime():
	return time
	
func setAmplitude(num : float):
	amplitude = num

func getAmplitude():
	return amplitude
	
func setFrequency(num : float):
	frequency = num
	
func getFrequency():
	return frequency

func _on_interaction_component_body_entered(body):
	if(body.is_in_group("Player")):
		if(item is Coin):
			Utils.getPlayer().getCurrencyComponent().addCoins(item.coin_value)
			deleteItem()
		elif(item is Item):
			Utils.getPlayer().getInventoryComponent().pickupItem(item)
			deleteItem()
		
