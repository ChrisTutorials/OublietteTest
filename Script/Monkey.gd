
#Monkey.gd
extends Node2D 

var hiscorpion = false
var gavekey = false



signal givekey

export (String, MULTILINE) var AltText
export(String, MULTILINE) var NPCDialogue
export(Texture) var NPC_Texture = null

var player_in_area

func _ready():

	pass

func _on_Area2D_body_entered(body):
	if(body is Player):
		player_in_area = body
func _on_Area2D_body_exited(body):
	if(body == player_in_area):
		player_in_area = null

func _process(_delta):
	if(player_in_area && Input.is_action_just_pressed("interact")):
		if gavekey == true:
			Textbox.queue_text("Thanks again!")
		elif hiscorpion == true and State.keys == 0:
			Textbox.queue_text(AltText)
			emit_signal("givekey")
			gavekey = true
		else:
			Textbox.queue_text(NPCDialogue)

func _on_Scorpion_himonkey():
	hiscorpion = true
