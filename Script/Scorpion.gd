extends StaticBody2D

var player_in_area
var saidhi = false
signal himonkey

func _process(_delta):
	if(player_in_area && Input.is_action_just_pressed("interact")):
		if saidhi == true:
			Textbox.queue_text("Thanks for playing with me ~~ \nTell Monke we had fun!")
			emit_signal("himonkey")
		else:
			Textbox.queue_text("Pio Pio Pio ~ \nHi there! I'm Scorpion. Sing with me <3")
			saidhi = true

func _on_Area2D_body_entered(body):
	if(body is Player):
		player_in_area = body

func _on_Area2D_body_exited(body):
	if(body == player_in_area):
		player_in_area = null

