extends Resource
class_name Inventory

export (String) var player_name = ""
export (int) var Money = 0 #aka coins
export (int) var Potions = 0
export (int) var Keys = 0
export (Array) var Collected = []
export (Array) var Items = [] #unused atm
export (int) var playerlevel = 1
export (int) var current_health = 10
export (int) var max_health = 10
export (int) var damage = 2
export (Array) var StatePrizes = []

func _init(saved_inventory : Resource = null):
	if(saved_inventory != null):
		player_name = saved_inventory.player_name
		Money = saved_inventory.Money
		Potions = saved_inventory.Potions
		Keys = saved_inventory.Keys
		Collected = saved_inventory.Collected
		Items = saved_inventory.Items
		playerlevel = saved_inventory.playerlevel
		current_health = saved_inventory.current_health
		max_health = saved_inventory.max_health
		damage = saved_inventory.damage
		StatePrizes = saved_inventory.StatePrizes
