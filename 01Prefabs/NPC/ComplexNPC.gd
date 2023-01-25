extends Node2D #Dialogue NPC

export(String, MULTILINE) var NPCDialogue = null
export(String, MULTILINE) var AltDialogue1 = null
export(Texture) var NPC_Texture = null

var player_in_area

func _ready():
	pass

func _process(_delta):
	if(player_in_area && Input.is_action_just_pressed("interact")):
		_push_text()
		_push_sound()
		
func _push_text():
	if AltDialogue1 != null:
		Textbox.queue_text(AltDialogue1)
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

