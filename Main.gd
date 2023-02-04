extends Node
#main.gd Opening Splash Screen
export(String, FILE) var start_scene
export(String) var start_location = "player_start"

# Load the starting level of the game
func _ready():
	get_tree().paused = true
	$AnimationPlayer.play("SplashDown")
	$Control/Start.hide()
	$Control/Button.hide()
	$Sprites.hide()

func _on_Start_pressed():
	GameManager.load_level(start_scene, start_location)
	get_tree().paused = false

func _on_Button_pressed():
	GameManager.load_game()
	get_tree().paused = false

func _on_AnimationPlayer_animation_finished(_SplashDown):
	$Control/Start.show()
	$Control/Button.show()
	$Sprites.show()
	$Control/Start.grab_focus()
