#savetest.gd
#autoload

extends Node

var player_level = 1
var player_health = 100


func save_data():
	var data = {
		"level": player_level,
		"health": player_health,
	}
	var file = File.new()
	if file.open("user://player_data.dat", File.WRITE) == OK:
		var serialized_data = JSON.print(data)
		file.store_string(serialized_data)
		file.close()

func load_data():
	var file = File.new()
	if file.open("user://player_data.dat", File.READ) == OK:
		var serialized_data = file.get_as_text()
		var data = JSON.parse(serialized_data)
		player_level = data["level"]
		player_health = data["health"]
		file.close()
