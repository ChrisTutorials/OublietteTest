extends Node

#used for pulling display data & stat info from the player inventory resource

var inventory setget , get_player_inventory

func get_player_inventory() -> Inventory:
	return GameManager.current_game_data.inventory

# var playerlevel = 1

#var current_health = 10
#var max_heatlh = 10

#var damage = 2

#var StatePrizes = []

#var coin_number = 0
#var potion_number = 0
#var keys = 0

#var collected = []

