extends Node2D #Door NPC

export(String, MULTILINE) var NPCDialogue = null
export(String, MULTILINE) var AltDialogue1 = null
export(String, MULTILINE) var OpenDialogue = null
export(Texture) var NPC_Texture = null

var player_in_area
var open = false

export var amount = 1

func _ready():
	pass

func _process(_delta):
	if(player_in_area && Input.is_action_just_pressed("interact")):
		_push_text()
	if open == true:
		$Sprite.hide()
		$CollisionShape2D.disabled = true

func _push_text():
	if open == true:
		Textbox.queue_text(OpenDialogue)
	elif State.keys >= amount:
		Textbox.queue_text(AltDialogue1)
		State.keys -= amount
		open = true
		_push_sound()
	else:
		Textbox.queue_text(NPCDialogue)

func _push_sound():
	if $Sound.stream == null:
		pass
	else:
		$Sound.play()

func _on_Area2D_body_entered(body):
	if(body is Player):
		player_in_area = body

func _on_Area2D_body_exited(body):
	if(body == player_in_area):
		player_in_area = null

