extends Area2D

export(String, FILE) var destination_level
export(String) var destination_spawn

# Test destination level and spawn input
func _ready():
	if(destination_level == null || destination_level == ""):
		printerr(self.name + " has no destination level")
	else:
		var testdir = Directory.new();
		var level_exists = testdir.file_exists(destination_level)
		
		if(!level_exists):
			printerr(self.name + " destination level - file does not exist at " + str(destination_level))
		
	if(destination_spawn == "" || destination_spawn == null):
		printerr(self.name + " has no destination spawn")

# When player moves into the area, detect that it is a player, and send it to another level
func _on_trigger_move_level_body_entered(body):
	if(body is Player):
		SceneChanger.scenefade()
		GameManager.load_level(destination_level, destination_spawn)
