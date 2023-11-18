extends Node
#GameManager #Autoload 
const FULL_FILE_PATH = "user://game-data.tres"
signal player_initialized
export(PackedScene) var player
export(Resource) var game_data
var spawn_loc : String
var active_player : Player

func load_level(level_path : String, spawn_location : String):
	self.spawn_loc = spawn_location
	var err = get_tree().change_scene(level_path)
	assert(err == OK)
	
	call_deferred("finish_loading_level")
	
	if(err != 0):
		printerr(err)

func load_game():
	if ResourceLoader.exists(FULL_FILE_PATH):
		var load_game_data = ResourceLoader.load(FULL_FILE_PATH)
		
		if(load_game_data != null):
			print("Save Data found! " + FULL_FILE_PATH)
			game_data = load_game_data
			#Load Level

			load_level(game_data.current_level, game_data.load_position)
		else:
			print_debug("No Save Data found!")

func finish_loading_level():
	var level = get_tree().current_scene
	
	assert(level is Level)
	
	if(level is Level):
		level.spawn_player(player, spawn_loc)
		level.load_level_state(get_level_state(level.filename))

func save_game(current_level : String, load_position : String):
	assert(active_player != null)
	print("SAVING GAME")
	game_data.current_level = current_level
	game_data.load_position = load_position
	game_data.item_state = active_player.save_state()
	
	var current_scene = get_tree().get_current_scene()
	
	if(current_scene is Level):
		
		var found_index = find_level_state_index(current_scene.filename)
		
		if(found_index >= 0):
			
			game_data.level_states[found_index] = current_scene.get_level_state() #Replace level data
		else:
			game_data.level_states.append(current_scene.get_level_state())
		
	
	assert(ResourceSaver.save(FULL_FILE_PATH, game_data, ResourceSaver.FLAG_BUNDLE_RESOURCES) == OK)
	print("GAME SAVED:" + FULL_FILE_PATH)

func get_level_state(level_filename : String):
	for state in game_data.level_states:
		if(state.filename == level_filename):
			return state

func find_level_state_index(level_filename : String):
	for i in len(game_data.level_states):
		if(game_data.level_states[i].filename == level_filename):
			print("Found at " + str(i))
			return i 
	return -1

func _process(_delta):
	if not player:
		initialize_player()
		return

func initialize_player():
	player = get_tree().get_root().get_node("/root/World/Player")
	if not player:
		return
	
	emit_signal("player_initialized", player)

###

func TestBattle():
	SceneChanger.battlefade()
	get_tree().change_scene("res://02test/Battle.tscn")
