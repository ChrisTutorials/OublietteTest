extends "res://Script/DialogueNPC.gd"
#Knife2

export (String) var item_name

export (int) var amount = 1

func _ready():
	if item_name in State.collected:
		self.queue_free()

func _process(_delta):
	
	if item_name in State.collected:
		self.queue_free()

	if(player_in_area && Input.is_action_just_pressed("interact")):
		
		#Textbox.queue_text("Opening ...")
		if player_in_area is Player:
			_npcitemget(player_in_area)


func _npcitemget(player : Player):
	
	State.StatePrizes.append(item_name)
	
	#player.inventory.Items.append(item_name)
	#player.inventory.StatePrizes.append(item_name)
	player.inventory.Collected.append(item_name)
	player.inventory.damage += amount
	State.damage = player.inventory.damage
	#State.StatePrizes = player.inventory.StatePrizes
	$Sound.play()
	print(player.inventory.Collected)
	#print("dmg" , player.inventory.damage)
	#print("prizes:" , player.inventory.StatePrizes)
