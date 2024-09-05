extends CharacterBody2D
class_name Player
#Export Variables
@export var inventory_component : InventoryComponent
@export var currency_component : CurrencyComponent
@export var health_component : HealthComponent
@onready var movement_speed : int = 100
@onready var state : String = "Idle"
@onready var isAction : bool = false
@onready var animator = $AnimationPlayer
@onready var last_direction : String = "Down"
@onready var direction : Vector2 = Vector2.ZERO
@onready var inventory : InventoryComponent = $InventoryComponent

signal coinsChanged(count : int)
signal inventoryChanged()
signal healthChanged(count : int)

func _ready():
	$ToolArea/Tool.set_disabled(true)
	$ToolArea.monitorable = false
	#Signals
	currency_component.coinsChanged.connect(_on_coin_update)
	#inventory_component.inventoryChanged.connect(_on_inventory_update)
	health_component.healthChanged.connect(_on_health_update)
	
func _physics_process(delta):
	if(Utils.getUI().isOpen() == false):
		#Get input direction
		var direction_input = Vector2(
			Input.get_action_strength("right") - Input.get_action_strength("left"),
			Input.get_action_strength("down") - Input.get_action_strength("up") 
		)
		var direction = direction_input.normalized()
		#Update animations
		if(isActioning()):
			pass
		elif(direction_input.x == 0 and direction_input.y == 0):
			if(last_direction == "Left"):
				$AnimationPlayer.play("idle_left")
			if(last_direction == "Down"):
				$AnimationPlayer.play("idle_down")
			if(last_direction == "Right"):
				$AnimationPlayer.play("idle_right")
			if(last_direction == "Up"):
				$AnimationPlayer.play("idle_up")
		elif(direction_input.x == -1 and direction_input.y == 0):
			$AnimationPlayer.play("walk_left")
			last_direction = "Left"
		elif(direction_input.x == 1 and direction_input.y == 0):
			$AnimationPlayer.play("walk_right")
			last_direction = "Right"
		elif(direction_input.y == 1 and direction_input.x == 0):
			$AnimationPlayer.play("walk_down")
			last_direction = "Down"
		elif(direction_input.y == -1 and direction_input.x == 0):
			$AnimationPlayer.play("walk_up")
			last_direction = "Up"
		elif(direction_input.x == -1 and direction_input.y != 0):
			$AnimationPlayer.play("walk_left")
			last_direction = "Left"
		elif(direction_input.x == 1 and direction_input.y != 0):
			$AnimationPlayer.play("walk_right")
			last_direction = "Right"
		#Update player velocity
		velocity = movement_speed * direction
		#Check for state change with velocity vector
		if(velocity != Vector2.ZERO):
			state = "Move"
		else:
			state = "Idle"
		#Move character with current direction and velocity
		move_and_slide()
		checkForButtonPress()
	if(Input.is_action_just_pressed("Menu")):
		Utils.getUI().menuToggle()

func checkForButtonPress():
	if(Input.is_action_just_pressed("1")):
		inventory.selectSlot(0,0)
	if(Input.is_action_just_pressed("2")):
		inventory.selectSlot(1,0)
	if(Input.is_action_just_pressed("3")):
		inventory.selectSlot(2,0)
	if(Input.is_action_just_pressed("4")):
		inventory.selectSlot(3,0)
	if(Input.is_action_just_pressed("5")):
		inventory.selectSlot(4,0)
	if(Input.is_action_just_pressed("6")):
		inventory.selectSlot(5,0)
	if(Input.is_action_just_pressed("7")):
		inventory.selectSlot(6,0)
	if(Input.is_action_just_pressed("8")):
		inventory.selectSlot(7,0)
	if(Input.is_action_just_pressed("9")):
		inventory.selectSlot(8,0)
	if(Input.is_action_just_pressed("0")):
		inventory.selectSlot(9,0)
	if(Input.is_action_just_pressed("drop")):
		inventory.dropItem()
	if(Input.is_action_pressed("click_primary")):
		if(inventory.selected.item != null):
			if(inventory.selected.item is Usable and isActioning() == false):
				useItem()
		
func getInventoryComponent():
	return inventory
	
func getCurrencyComponent():
	return currency_component
	
func getHealthComponent():
	return health_component
	
func getDropMarker():
	return $Marker2D
	
func useItem():
	if(inventory.selected.getItem() is Usable):
		isAction = true
		if(inventory.selected.getItem().getName() == "Axe"):
			movement_speed = 0
			$ToolArea/Tool.set_disabled(false)
			$ToolArea.monitorable = true
			state = "Axe"
			if(last_direction == "Left"):
				$AnimationPlayer.play("axe_left")
			elif(last_direction == "Down"):
				$AnimationPlayer.play("axe_down")
			elif(last_direction == "Right"):
				$AnimationPlayer.play("axe_right")
			elif(last_direction == "Up"):
				$AnimationPlayer.play("axe_up")
			await get_tree().create_timer(0.35).timeout
			Utils.getGameAudio().playSound("res://Audio/SFX/Player/AxeSwing.wav")
		elif(inventory.selected.getItem().getName() == "Hoe"):
			movement_speed = 0
			state = "Hoe"
			if(last_direction == "Left"):
				$AnimationPlayer.play("hoe_left")
			elif(last_direction == "Down"):
				$AnimationPlayer.play("hoe_down")
			elif(last_direction == "Right"):
				$AnimationPlayer.play("hoe_right")
			elif(last_direction == "Up"):
				$AnimationPlayer.play("hoe_up")
			Utils.getGameAudio().playSound("res://Audio/SFX/Player/DirtDig.mp3")
		elif(inventory.selected.getItem().getName() == "Watering Can"):
			movement_speed = 0
			state = "Watering"
			if(last_direction == "Left"):
				$AnimationPlayer.play("water_left")
			elif(last_direction == "Down"):
				$AnimationPlayer.play("water_down")
			elif(last_direction == "Right"):
				$AnimationPlayer.play("water_right")
			elif(last_direction == "Up"):
				$AnimationPlayer.play("water_up")
		
func useItemEnd():
	$ToolArea/Tool.set_disabled(true)
	$ToolArea.monitorable = false
	movement_speed = 100
	isAction = false

func _on_animation_player_animation_finished(anim_name):
	if(anim_name == "axe_down" or anim_name == "axe_left" or anim_name == "axe_up" or anim_name == "axe_right"):
		useItemEnd()
	elif(anim_name == "hoe_down" or anim_name == "hoe_left" or anim_name == "hoe_up" or anim_name == "hoe_right"):
		useItemEnd()
	elif(anim_name == "water_down" or anim_name == "water_left" or anim_name == "water_up" or anim_name == "water_right"):
		useItemEnd()
		
func isActioning():
	return isAction
	
func _on_coin_update(count : int):
	coinsChanged.emit(count)
	
func _on_health_update(count : int):
	healthChanged.emit(count)
	
func _on_inventory_update():
	pass
