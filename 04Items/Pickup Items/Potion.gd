extends "res://01Prefabs/Item/Pickup.gd"
#potion.gd

export(int) var amount = 1

onready var potion = get_name()

func _pickup(player : Player):
	
	player.inventory.Potions += amount
	# State.potion_number = player.inventory.Potions
	print("Potions held: ", player.inventory.Potions)
	self.enabled = false
	
	player.inventory.Collected.append(potion)
	# State.collected = player.inventory.Collected
	print(State.inventory.Collected)

func _update_potions():
	if potion in State.inventory.Collected:
		self.enabled = false

	
func _ready():
	_update_potions()

func _process(_delta):
	_update_potions()
