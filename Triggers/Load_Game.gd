extends Area2D
#load_game.gd
var player_in_area

func _process(delta):
	if(player_in_area && Input.is_action_just_pressed("interact")):
		load_game()

func load_game():
	GameManager.load_game()

func _on_Save_Game_body_entered(body):
	if(body is Player):
		player_in_area = body

func _on_Save_Game_body_exited(body):
	if(body == player_in_area):
		player_in_area = null
