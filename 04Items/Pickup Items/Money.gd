extends "res://01Prefabs/Item/Pickup.gd"
#money.gd

export(int) var amount = 1

onready var money = get_name()

func _pickup(player : Player):
	
	State.coin_number += amount
	
	player.inventory.Money += amount
	print("Money held: ", player.inventory.Money)
	self.enabled = false
	
	#State.collected.append(money)
	
	player.inventory.Collected.append(money)
	print(player.inventory.Collected)
	print(State.collected)
	
func _ready():
	if money in State.collected:
		self.enabled = false
