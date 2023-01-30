extends "res://Script/DialogueNPC.gd"

export var damage = 1

func _physics_process(delta):
	if(player_in_area && Input.is_action_just_pressed("interact")):
		State.damage += damage
		$Sound.play()
		yield($Sound, "finished")
		queue_free()
