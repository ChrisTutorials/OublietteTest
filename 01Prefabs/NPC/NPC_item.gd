extends "res://Script/DialogueNPC.gd"

#treasure chest prototype

export (String) var item_name


func _process(_delta):
	if(player_in_area && Input.is_action_just_pressed("interact")):
		
		#Textbox.queue_text("Opening ...")
		if player_in_area is Player:
			_npcitemget(player_in_area)


func _npcitemget(player : Player):
	
	player.inventory.Items.append(item_name)
	
	print(player.inventory.Items)
