class_name PlayerUI
extends Control

# Variables
var player_inventory : InventoryComponent
var player_currency : CurrencyComponent
var player_health : HealthComponent
var menu_open : bool
var moving_item
var popup
# Onready Variables
@onready var hotbar = $HotbarRect/Hotbar

# Functions
func _ready():
	# Setup currency component UI
	player_currency = Utils.get_player().get_currency_component()
	Utils.get_player().coins_changed.connect(_on_coin_update)
	$PlayerInfo/CoinContainer/CoinCounter.text = str(player_currency.get_coin_count())
	# Setup health component UI
	player_health = Utils.get_player().get_health_component()
	$PlayerInfo/HealthContainer/HealthCounter.text = (str(player_health.get_health()) + "/" + str(player_health.get_max_health()))
	Utils.get_player().health_changed.connect(_on_hp_update)

	$CenterMenu.hide()
	$HotbarRect.show()
	
	
func menu_toggle():
	if(menu_open == false):
		$CenterMenu.show()
		$HotbarRect.hide()
		menu_open = true
		Utils.get_game_audio().play_sound("res://Audio/SFX/Inventory/InventoryOpen.wav")
	else:
		$CenterMenu.hide()
		$HotbarRect.show()
		menu_open = false
		Utils.get_game_audio().play_sound("res://Audio/SFX/Inventory/InventoryClose.wav")
	
	
func _on_coin_update(count: int):
	$PlayerInfo/CoinContainer/CoinCounter.text = str(count)
	
	
func _on_hp_update(count: int):
	print(str(count))
	$PlayerInfo/HealthContainer/HealthCounter.text = str(count) + "/" + str(player_health.get_math_health())


func is_open():
	return menu_open
	

func set_popup(new_popup):
	popup = new_popup
	add_child(popup)
	

func has_popup():
	if(popup == null):
		return false
	else:
		return true
