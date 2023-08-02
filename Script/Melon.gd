extends Node2D #Melon.gd
export(String, MULTILINE) var NPCDialogue
export(String, MULTILINE) var AltDialogue1
export(Texture) var NPC_Texture = null
var player_in_area
func _ready():
	#$Sprite.set_texture(NPC_Texture)
	pass

func _process(_delta):
	if(player_in_area && Input.is_action_just_pressed("interact")):
		if State.coin_number >= 10:
			Textbox.queue_text(AltDialogue1)
			$AnimationPlayer.play("pentag")
			yield($AnimationPlayer, "animation_finished")
			$Sprite.visible = false
			$CollisionShape2D.disabled = true
			$MelonSound.play()
			yield($MelonSound, "finished")
			$Area2D/CollisionShape2D.disabled = true


		else:
			Textbox.queue_text(NPCDialogue)

func _on_Area2D_body_entered(body):
	if(body is Player):
		player_in_area = body

func _on_Area2D_body_exited(body):
	if(body == player_in_area):
		player_in_area = null

