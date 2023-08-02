extends StaticBody2D

var player_in_area
var dialog = ConfirmationDialog.new()

func _ready():
	pass

func _process(_delta):
	if(player_in_area && Input.is_action_just_pressed("interact")):
		

		GameManager.TestBattle()

func _on_Area2D_body_entered(body):
	if(body is Player):
		player_in_area = body

func _on_Area2D_body_exited(body):
	if(body == player_in_area):
		player_in_area = null
