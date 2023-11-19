extends Area2D
#save_game.gd

export(String) var load_position_name = "load_position"

var player_in_area

func _process(_delta):
	if(player_in_area && Input.is_action_just_pressed("interact")):
		
		save()
		
func save():
	GameManager.save_game(get_tree().get_current_scene().filename,load_position_name)
	$Sound.play()
	get_tree().paused = true
	
	$AnimationPlayer.play("SaveScreen")

func _on_Save_Game_body_entered(body):
	if(body is Player):
		player_in_area = body

func _on_Save_Game_body_exited(body):
	if(body == player_in_area):
		player_in_area = null

func _on_AnimationPlayer_animation_finished(_anim_name):
		Textbox.queue_text("Game Saved!")
