class_name Player
extends CharacterBody2D

# Signals
signal coins_changed(count : int)
signal inventory_changed()
signal health_changed(count : int)

# Export Variables
@export var inventory_component : InventoryComponent
@export var currency_component : CurrencyComponent
@export var health_component : HealthComponent
@export var audio_component : AudioMachine

# Variables
var movement_speed : int = 100
var state : String = "Idle"
var isAction : bool = false
var last_direction : String = "Down"
var direction : Vector2 = Vector2.ZERO

# Onready Variables
@onready var animator = $AnimationPlayer
@onready var inventory : InventoryComponent = $InventoryComponent
@onready var currency : CurrencyComponent = $CurrencyComponent
@onready var audio_player : AudioMachine = $AudioMachine

# Functions
func _ready():
	Utils.set_player(self)
	$ToolArea/Tool.set_disabled(true)
	$ToolArea.monitorable = false
	#Signals
	currency_component.coins_changed.connect(_on_coin_update)
	#inventory_component.inventoryChanged.connect(_on_inventory_update)
	health_component.health_changed.connect(_on_health_update)
	
	
func _physics_process(delta):
	if(false == false):
		#Get input direction
		var direction_input = Vector2(
			Input.get_action_strength("right") - Input.get_action_strength("left"),
			Input.get_action_strength("down") - Input.get_action_strength("up") 
		)
		var direction = direction_input.normalized()
		#Update animations
		if(is_actioning()):
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
		check_for_button_press()
	if(Input.is_action_just_pressed("Menu")):
		Utils.get_ui().menu_toggle()


func check_for_button_press():
	if(Input.is_action_just_pressed("1")):
		inventory.select_slot(0,0)
	if(Input.is_action_just_pressed("2")):
		inventory.select_slot(1,0)
	if(Input.is_action_just_pressed("3")):
		inventory.select_slot(2,0)
	if(Input.is_action_just_pressed("4")):
		inventory.select_slot(3,0)
	if(Input.is_action_just_pressed("5")):
		inventory.select_slot(4,0)
	if(Input.is_action_just_pressed("6")):
		inventory.select_slot(5,0)
	if(Input.is_action_just_pressed("7")):
		inventory.select_slot(6,0)
	if(Input.is_action_just_pressed("8")):
		inventory.select_slot(7,0)
	if(Input.is_action_just_pressed("9")):
		inventory.select_slot(8,0)
	if(Input.is_action_just_pressed("0")):
		inventory.select_slot(9,0)
	if(Input.is_action_just_pressed("drop")):
		inventory.drop_item()
	if(Input.is_action_pressed("click_primary")):
		if(inventory.selected.item != null):
			if(inventory.selected.item is Usable and is_actioning() == false):
				use_item()
		
		
func get_inventory_component():
	return inventory
	
	
func get_currency_component():
	return currency_component
	
	
func get_health_component():
	return health_component
	
	
func get_drop_marker():
	return $Marker2D
	
	
func use_item():
	if(inventory.selected.get_item() is Usable):
		isAction = true
		if(inventory.selected.get_item().get_name() == "Axe"):
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
			audio_component.play_sound("res://Audio/SFX/Player/AxeSwing.wav")
		elif(inventory.selected.get_item().get_name() == "Hoe"):
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
			audio_component.play_sound("res://Audio/SFX/Player/DirtDig.mp3")
		elif(inventory.selected.get_item().get_name() == "Watering Can"):
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
		
		
func use_item_end():
	$ToolArea/Tool.set_disabled(true)
	$ToolArea.monitorable = false
	movement_speed = 100
	isAction = false


func _on_animation_player_animation_finished(anim_name):
	if(anim_name == "axe_down" or anim_name == "axe_left" or anim_name == "axe_up" or anim_name == "axe_right"):
		use_item_end()
	elif(anim_name == "hoe_down" or anim_name == "hoe_left" or anim_name == "hoe_up" or anim_name == "hoe_right"):
		use_item_end()
	elif(anim_name == "water_down" or anim_name == "water_left" or anim_name == "water_up" or anim_name == "water_right"):
		use_item_end()
		
		
func is_actioning():
	return isAction
	
	
func _on_coin_update(count : int):
	coins_changed.emit(count)
	
	
func _on_health_update(count : int):
	health_changed.emit(count)
	

func _on_inventory_component_sound_emitted(sound: Variant) -> void:
	audio_component.play_sound(sound)
	
func save():
	var children_data = []
	for child in get_children():
		if child.has_method("save"):
			children_data.append(child.save())  # Recursively save child nodes
	var save_dict = {
		"scene" : get_scene_file_path(),
		"save_file_path" : "res://LocalData/PlayerData.json",
		"properties" : {
			"position" : position
		},
		"children": children_data
	}
	return save_dict
	
