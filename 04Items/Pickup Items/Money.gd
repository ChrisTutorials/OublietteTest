extends "res://01Prefabs/Item/Pickup.gd"
#money.gd

export(int) var amount = 1

onready var money = get_name()

func _pickup(player : Player):
	
	player.inventory.Money += amount
	State.coin_number = player.inventory.Money
	print("Money: ", player.inventory.Money) 
	self.enabled = false
	
	player.inventory.Collected.append(money)
	State.collected = player.inventory.Collected
	print(State.collected)
	
func _ready():
	if money in State.collected:
		self.enabled = false

func _process(_delta):
	if money in State.collected:
		self.enabled = false
