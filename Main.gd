extends Node
#main.gd Opening Splash Screen
export(String, FILE) var start_scene
export(String) var start_location = "player_start"

export(String, FILE) var destination_level
export(String) var destination_spawn

export(String, FILE) var debug_level

# Load the starting level of the game
func _ready():
	get_tree().paused = true
	$AnimationPlayer.play("SplashDown")
	$Control/Start.hide()
	$Control/Button.hide()
	$Sprites.hide()

func _on_Start_pressed():
	GameManager.start_game(start_scene, start_location)
	get_tree().paused = false

func _on_Button_pressed():
	GameManager.load_game()
	get_tree().paused = false

func _on_AnimationPlayer_animation_finished(_SplashDown):
	$Control/Start.show()
	$Control/Button.show()
	$Sprites.show()
	$Control/Start.grab_focus()

func _on_DEBUG_pressed():
	GameManager.start_game(debug_level, start_location)
	get_tree().change_scene(debug_level)
	get_tree().paused = false

func _on_ROOMTEST_pressed():
	GameManager.start_game(destination_level, destination_spawn)
	get_tree().paused = false
