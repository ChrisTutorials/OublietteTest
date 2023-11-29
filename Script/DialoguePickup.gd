extends "res://Script/DialogueNPC.gd"
#old knife script 
export var damage = 1


var knife = "Knife"

func _ready():
	if knife in Graveyard.bin:
		self.queue_free()


func _physics_process(delta):
	if(player_in_area && Input.is_action_just_pressed("interact")):
		State.damage += damage
		$Sound.play()
		yield($Sound, "finished")
		State.StatePrizes.append("Knife")
		queue_free()
		Graveyard.bin.append("Knife")
		print(Graveyard.bin)
		
