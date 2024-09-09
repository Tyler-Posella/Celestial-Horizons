extends Control
class_name PlayerUI
# Variables
var player_inventory : InventoryComponent
var player_currency : CurrencyComponent
var player_health : HealthComponent
var menu_open : bool
@onready var hotbar = $HotbarRect/Hotbar

# Functions
func _ready():
	#Signal connections
	Utils.getPlayer().coinsChanged.connect(_on_coin_update)
	Utils.getPlayer().healthChanged.connect(_on_hp_update)
	$CenterMenu.hide()
	$HotbarRect.show()
	
	
func menuToggle():
	if(menu_open == false):
		$CenterMenu.show()
		$HotbarRect.hide()
		menu_open = true
		Utils.getGameAudio().playSound("res://Audio/SFX/Inventory/InventoryOpen.wav")
	else:
		$CenterMenu.hide()
		$HotbarRect.show()
		menu_open = false
		Utils.getGameAudio().playSound("res://Audio/SFX/Inventory/InventoryClose.wav")
	
	
func _on_coin_update(count: int):
	$PlayerInfo/CoinContainer/CoinCounter.text = str(count)
	
	
func _on_hp_update(count: int):
	print(str(count))
	$PlayerInfo/HealthContainer/HealthCounter.text = str(count) + "/" + str(player_health.getMaxHealth())


func isOpen():
	return menu_open
