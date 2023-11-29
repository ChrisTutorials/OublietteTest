extends "res://01Prefabs/Item/Pickup.gd"
#key.gd


export(int) var amount = 1

func _pickup(player : Player):
	State.keys += amount
	player.inventory.Keys += amount
	print("Keys: ", player.inventory.Keys)
	self.enabled = false

