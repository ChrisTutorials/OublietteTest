extends "res://01Prefabs/Item/Pickup.gd"
#potion.gd

export(int) var amount = 1

func _pickup(player : Player):
	State.potion_number += amount
	player.inventory.Potions += amount
	print("Potions held: ", player.inventory.Potions)
	self.enabled = false
