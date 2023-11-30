extends Node2D

#Chest1.gd

export(String, MULTILINE) var Chest_Text


export (Texture) var opened_texture
export (String) var item_name
signal opened
var player_in_area


func _ready():
	_update_chest()

func _process(_delta):
	
	_update_chest()
	
	if(player_in_area && Input.is_action_just_pressed("interact")):
		if item_name in State.collected:
			_update_chest()
			Textbox.queue_text("Empty ...")
		
		#Textbox.queue_text("Opening ...")
		elif player_in_area is Player:
			$Sound.play()
			_item_get(player_in_area)
			Textbox.queue_text(Chest_Text)
			emit_signal("opened")
			State.StatePrizes.append(item_name)


func _item_get(player : Player):
	player.inventory.Items.append(item_name)
	player.inventory.Collected.append(item_name)
	State.collected = player.inventory.Collected
	print("Collected: " , player.inventory.Collected)
	print("Items:" , player.inventory.Items)

func _on_Chest_opened():
	$Sprite.texture = opened_texture

func _update_chest():
	if item_name in State.collected:
		$Sprite.texture = opened_texture


func _on_Area2D_body_entered(body):
	if(body is Player):
		player_in_area = body

func _on_Area2D_body_exited(body):
	if(body == player_in_area):
		player_in_area = null
