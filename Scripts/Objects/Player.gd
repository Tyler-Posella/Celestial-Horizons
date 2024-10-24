class_name Player
extends CharacterBody2D

# Signals
signal coins_changed(count : int)
signal inventory_changed()
signal health_changed(count : int)
signal hoed()

# Variables
var movement_speed : int = 100
var state : String = "Idle"
var is_action : bool = false
var last_direction : String = "Down"
var facing_direction : Vector2
var direction : Vector2 = Vector2.ZERO
var position_x : float
var position_y : float
var player_name : String
var playtime : int
var if_check


# Onready Variables
@onready var animator = $AnimationPlayer
@onready var inventory_component : InventoryComponent = $InventoryComponent
@onready var health_component : HealthComponent = $HealthComponent
@onready var currency_component : CurrencyComponent = $CurrencyComponent
@onready var audio_player : AudioMachine = $AudioMachine
@onready var item_gravity_component : ItemGravityComponent = $ItemGravityComponent

# Functions
func _ready():
	position.x = position_x
	position.y = position_y
	# Reassign currency component
	for child in get_children():
		if child is CurrencyComponent:
			currency_component = child
			currency_component.coins_changed.connect(_on_coin_update)
			currency_component.sound_emitted.connect(_on_currency_component_sound_emitted)
	
	# Reassign health component
	for child in get_children():
		if child is HealthComponent:
			health_component = child
			health_component.health_changed.connect(_on_health_update)
			
	# Reassign inventory component
	for child in get_children():
		if child is InventoryComponent:
			inventory_component = child
	inventory_component.sound_emitted.connect(_on_inventory_component_sound_emitted)
	
	Game.set_player(self)
	$ToolArea/Tool.set_disabled(true)
	$ToolArea.monitorable = false
	
	$WalkPlayer.stream = load("res://Audio/SFX/Player/Footsteps_Grass_Run.wav")
	
func _physics_process(delta):
	if(1 == 1):
		#Get input direction
		var direction_input = Vector2(
			Input.get_action_strength("right") - Input.get_action_strength("left"),
			Input.get_action_strength("down") - Input.get_action_strength("up") 
		)
		var direction = direction_input.normalized()
		#Update animations
		if(is_actioning()):
			pass
		elif(direction == Vector2.ZERO):
			$AnimationPlayer.speed_scale = 1
			# Get the global mouse position
			var mouse_position = get_global_mouse_position()
			# Get the player's position
			var player_position = self.global_position
			# Calculate the direction vector from the player to the mouse
			facing_direction = (mouse_position - player_position).normalized()
			if abs(facing_direction.x) > abs(facing_direction.y):
		# Horizontal facing (left or right)
				if facing_direction.x > 0:
					$AnimationPlayer.play("idle_right")
				else:
					$AnimationPlayer.play("idle_left")
			else:
			# Vertical facing (up or down)
				if facing_direction.y > 0:
					$AnimationPlayer.play("idle_down")
				else:
					$AnimationPlayer.play("idle_up")
		else:
			if($Timer2.time_left <= 0):
				$AnimationPlayer.speed_scale = 1.75
				$WalkPlayer.pitch_scale = randf_range(0.8, 1.2)
				$WalkPlayer.play()
				$Timer2.start(0.3)
			if(direction_input.x == -1 and direction_input.y == 0):
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
		Game.get_ui().menu_toggle()


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
			if(inventory_component.selected.item is UsableRes and is_actioning() == false):
				use_item()
			if(inventory_component.selected.item is SeedPackRes and is_actioning() == false):
				plant()
		
		
func plant():
	pass
	
	
func hoe():
	SignalManager.emit_signal_global("player_hoed", [])
	
	
func water():
	SignalManager.emit_signal_global("player_watered", [])
	
	
func get_inventory_component():
	return inventory_component
	
	
func get_currency_component():
	return currency_component
	
	
func get_health_component():
	return health_component
	
	
func get_drop_marker():
	return $Marker2D
	
	
func use_item():
	$AnimationPlayer.speed_scale = 1
	if(inventory_component.selected.get_item() is UsableRes):
		is_action = true
		movement_speed = 0
		$ToolArea/Tool.set_disabled(false)
		$ToolArea.monitorable = true
		if(inventory_component.get_selected_slot().get_item().get_item_name() == "Axe"):
			state = "Axe"
			$ToolArea.set_collision_layer_value(9, true)
			if abs(facing_direction.x) > abs(facing_direction.y):
			# Horizontal facing (left or right)
				if facing_direction.x > 0:
					$AnimationPlayer.play("axe_right")
				else:
					$AnimationPlayer.play("axe_left")
			else:
			# Vertical facing (up or down)
				if facing_direction.y > 0:
					$AnimationPlayer.play("axe_down")
				else:
					$AnimationPlayer.play("axe_up")
			await get_tree().create_timer(0.35).timeout
			audio_player.play_sound("res://Audio/SFX/Player/AxeSwing.wav")
		elif(inventory_component.get_selected_slot().get_item().get_item_name() == "Hoe"):
			state = "Hoe"
			$ToolArea.set_collision_layer_value(10, true)
			if abs(facing_direction.x) > abs(facing_direction.y):
			# Horizontal facing (left or right)
				if facing_direction.x > 0:
					$AnimationPlayer.play("hoe_right")
				else:
					$AnimationPlayer.play("hoe_left")
			else:
			# Vertical facing (up or down)
				if facing_direction.y > 0:
					$AnimationPlayer.play("hoe_down")
				else:
					$AnimationPlayer.play("hoe_up")
			hoe()
			audio_player.play_sound("res://Audio/SFX/Player/DirtDig.mp3")
		elif(inventory_component.get_selected_slot().get_item().get_item_name() == "Watering Can"):
			state = "Watering"
			if abs(facing_direction.x) > abs(facing_direction.y):
			# Horizontal facing (left or right)
				if facing_direction.x > 0:
					$AnimationPlayer.play("water_right")
				else:
					$AnimationPlayer.play("water_left")
			else:
			# Vertical facing (up or down)
				if facing_direction.y > 0:
					$AnimationPlayer.play("water_down")
				else:
					$AnimationPlayer.play("water_up")
			water()
		
		
func use_item_end():
	$ToolArea/Tool.set_disabled(true)
	$ToolArea.monitorable = false
	movement_speed = 100
	is_action = false


func _on_animation_player_animation_finished(anim_name):
	if(anim_name == "axe_down" or anim_name == "axe_left" or anim_name == "axe_up" or anim_name == "axe_right"):
		$ToolArea.set_collision_layer_value(9, false)
		use_item_end()
	elif(anim_name == "hoe_down" or anim_name == "hoe_left" or anim_name == "hoe_up" or anim_name == "hoe_right"):
		$ToolArea.set_collision_layer_value(10, false)
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
		"save_file_path" : "PlayerData.json",
		"properties" : {
			"position_x" : position.x,
			"position_y" : position.y,
			"name" : player_name,
			"playtime" : playtime
		},
		"children": children_data,
		"unique" : true
	}
	return save_dict
	

func set_player_name(new_name : String):
	player_name = new_name
	
	
func _on_timer_timeout() -> void:
	playtime = playtime + 1
	$Timer.start()
