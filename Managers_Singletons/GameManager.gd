extends Node
#GameManager #Autoload 
const FULL_FILE_PATH = "user://game-data.tres"
signal player_initialized
export(PackedScene) var player
export(Resource) var default_game_data : Resource # Set defaults in editor
var spawn_loc : String
var active_player : Player

## The current game state
var current_game_data : Resource 

func _ready():
	_validate_game_data(default_game_data)
	
## Call this to start the game with a new save state
func start_game(level_path : String, spawn_location : String):
	current_game_data = default_game_data
	load_level(level_path, spawn_location)
	
## Loads a level but does not reset the save state
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
			current_game_data = null # Clear current game state
			current_game_data = load_game_data
			print("Save Data found! " + FULL_FILE_PATH)
			print_debug("Trying to load level " + current_game_data.current_level)
			load_level(current_game_data.current_level, current_game_data.load_position)
		else:
			push_error("Resource Error: Not Found")
	else:
		print_debug("No Save Data in app_userdata")
		Textbox.queue_text("Oops! No Save Data!")

## Setup the player and other level object states
func finish_loading_level():
	var level = get_tree().current_scene
	
	assert(level is Level)
	
	if(level is Level):
		level.spawn_player(player, spawn_loc)
		level.load_level_state(get_level_state(level.filename))
		active_player.load_state(current_game_data.inventory)

func save_game(current_level : String, load_position : String):
	assert(active_player != null)
	print("SAVING GAME")
	var new_save_data = GameData.new()
	new_save_data.current_level = current_level
	new_save_data.load_position = load_position
	new_save_data.inventory = active_player.inventory
	print_debug(str(new_save_data.inventory.Money) + " Money")
	
	var current_scene = get_tree().get_current_scene()
	
	if(current_scene is Level):
		
		var found_index = find_level_state_index(current_scene.filename)
		
		if(found_index >= 0):
			
			new_save_data.level_states[found_index] = current_scene.get_level_state() #Replace level data
		else:
			new_save_data.level_states.append(current_scene.get_level_state())
		
	
	assert(ResourceSaver.save(FULL_FILE_PATH, new_save_data, ResourceSaver.FLAG_BUNDLE_RESOURCES) == OK)
	
	print("GAME SAVED:" + FULL_FILE_PATH)

func get_level_state(level_filename : String):
	for state in current_game_data.level_states:
		if(state.filename == level_filename):
			return state

func find_level_state_index(level_filename : String):
	for i in len(current_game_data.level_states):
		if(current_game_data.level_states[i].filename == level_filename):
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

## Use this to check that the nested resources are set on the manager correctly
func _validate_game_data(p_game_data : Resource):
	assert(p_game_data)
	assert(p_game_data.inventory)

###

func TestBattle():
	SceneChanger.battlefade()
	get_tree().change_scene("res://02test/Battle.tscn")
