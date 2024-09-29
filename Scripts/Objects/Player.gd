class_name Player
extends CharacterBody2D

# Signals
signal coins_changed(count : int)
signal inventory_changed()
signal health_changed(count : int)


# Variables
var movement_speed : int = 100
var state : String = "Idle"
var is_action : bool = false
var last_direction : String = "Down"
var direction : Vector2 = Vector2.ZERO
var position_x : float
var position_y : float
var children

# Onready Variables
@onready var animator = $AnimationPlayer
@onready var inventory_component : InventoryComponent = $InventoryComponent
@onready var health_component : HealthComponent = $HealthComponent
@onready var currency_component : CurrencyComponent = $CurrencyComponent
@onready var audio_player : AudioMachine = $AudioMachine

# Functions
func _ready():
	children = get_children()
	position.x = position_x
	position.y = position_y
	# Reassign currency component
	for child in get_children():
		if child is CurrencyComponent:
			print(child)
			currency_component = child
			currency_component.coins_changed.connect(_on_coin_update)
			currency_component.sound_emitted.connect(_on_currency_component_sound_emitted)
	
	# Reassign health component
	for child in get_children():
		if child is HealthComponent:
			print(child)
			health_component = child
			health_component.health_changed.connect(_on_health_update)
			
	# Reassign inventory component
	for child in get_children():
		if child is InventoryComponent:
			inventory_component = child
	inventory_component.sound_emitted.connect(_on_inventory_component_sound_emitted)
	
	Utils.set_player(self)
	$ToolArea/Tool.set_disabled(true)
	$ToolArea.monitorable = false
	
	
func _physics_process(delta):
	if(Utils.get_ui().is_open() == false):
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
		inventory_component.select_slot(0)
	if(Input.is_action_just_pressed("2")):
		inventory_component.select_slot(1)
	if(Input.is_action_just_pressed("3")):
		inventory_component.select_slot(2)
	if(Input.is_action_just_pressed("4")):
		inventory_component.select_slot(3)
	if(Input.is_action_just_pressed("5")):
		inventory_component.select_slot(4)
	if(Input.is_action_just_pressed("6")):
		inventory_component.select_slot(5)
	if(Input.is_action_just_pressed("7")):
		inventory_component.select_slot(6)
	if(Input.is_action_just_pressed("8")):
		inventory_component.select_slot(7)
	if(Input.is_action_just_pressed("9")):
		inventory_component.select_slot(8)
	if(Input.is_action_just_pressed("0")):
		inventory_component.select_slot(9)
	if(Input.is_action_just_pressed("drop")):
		inventory_component.drop_item()
	if(Input.is_action_pressed("click_primary")):
		if(inventory_component.selected.item != null):
			if(inventory_component.selected.item is Usable and is_actioning() == false):
				use_item()
		
		
func get_inventory_component():
	return inventory_component
	
	
func get_currency_component():
	return currency_component
	
	
func get_health_component():
	return health_component
	
	
func get_drop_marker():
	return $Marker2D
	
	
func use_item():
	if(inventory_component.selected.get_item() is Usable):
		is_action = true
		if(inventory_component.get_selected_slot().get_item().get_item_name() == "Axe"):
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
			audio_player.play_sound("res://Audio/SFX/Player/AxeSwing.wav")
		elif(inventory_component.get_selected_slot().get_item().get_item_name() == "Hoe"):
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
			audio_player.play_sound("res://Audio/SFX/Player/DirtDig.mp3")
		elif(inventory_component.get_selected_slot().get_item().get_item_name() == "Watering Can"):
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
	is_action = false


func _on_animation_player_animation_finished(anim_name):
	if(anim_name == "axe_down" or anim_name == "axe_left" or anim_name == "axe_up" or anim_name == "axe_right"):
		use_item_end()
	elif(anim_name == "hoe_down" or anim_name == "hoe_left" or anim_name == "hoe_up" or anim_name == "hoe_right"):
		use_item_end()
	elif(anim_name == "water_down" or anim_name == "water_left" or anim_name == "water_up" or anim_name == "water_right"):
		use_item_end()
		
		
func is_actioning():
	return is_action
	
	
func _on_coin_update(count : int):
	coins_changed.emit(count)
	
	
func _on_health_update(count : int):
	health_changed.emit(count)
	

func _on_inventory_component_sound_emitted(sound: Variant) -> void:
	audio_player.play_sound(sound)
	
	
func _on_currency_component_sound_emitted(sound: Variant) -> void:
	audio_player.play_sound(sound)
	
	
func save():
	var children_data = []
	for child in get_children():
		if child.has_method("save"):
			children_data.append(child.save())  # Recursively save child nodes
	var save_dict = {
		"scene" : get_scene_file_path(),
		"save_file_path" : "res://LocalData/PlayerData.json",
		"properties" : {
			"position_x" : position.x,
			"position_y" : position.y
		},
		"children": children_data,
		"unique" : true
	}
	return save_dict
	
