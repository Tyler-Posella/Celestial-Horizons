extends Node2D
class_name CurrencyComponent
#Variables
var coin_count : int = 0

signal coinsChanged(count : int)

func getCoinCount():
	return coin_count

func setCounCount(count : int):
	coin_count = count
	coinsChanged.emit(coin_count)
	
func addCoins(count : int):
	coin_count = coin_count + count
	Utils.getGameAudio().playSound("res://Audio/SFX/Inventory/CoinPickup.wav")
	coinsChanged.emit(coin_count)
