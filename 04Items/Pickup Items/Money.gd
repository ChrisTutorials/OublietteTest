extends "res://01Prefabs/Item/Pickup.gd"
#money.gd

export(int) var amount = 1

func _pickup(player : Player):
	State.coin_number += amount
	player.inventory.Money += amount
	print("Money held: ", player.inventory.Money)
	self.enabled = false

