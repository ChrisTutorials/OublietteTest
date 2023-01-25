extends Node2D
#Level.gd
class_name Level

export(NodePath) onready var level_camera = get_node(level_camera)
export(NodePath) onready var game_objects = get_node(game_objects)
export(NodePath) onready var transitions = get_node(transitions)
export(NodePath) onready var spawn_points = get_node(spawn_points)

var player_instance
var camera_target : RemoteTransform2D
var save_objs

func _ready():
	#spawn_player(GameManager.player, GameManager.spawn_loc) old
	save_objs = get_tree().get_nodes_in_group(GDict.saveable_objects_group)

func spawn_player(player_scene : PackedScene, spawn_point_name : String):
	var spawn_point = spawn_points.find_node(spawn_point_name)

	if(spawn_point):
		# Create player, assign camera and remote transform to follow player
		self.player_instance = player_scene.instance()
		
		game_objects.add_child(player_instance)
		
		# Move player to proper spawn location
		player_instance.global_position = spawn_point.position
		
		# Create a target for the camera to point at on the player
		self.camera_target = RemoteTransform2D.new()
		player_instance.add_child(camera_target)
		camera_target.remote_path = level_camera.get_path()
		
	else:
		printerr("Can't find spawn point " + spawn_point_name + " in level " + self.name)

func get_level_state():
	var level_state = LevelState.new()
	
	level_state.filename = filename
	
	var obj_save_names = []
	
	for save_obj in save_objs:
		assert(save_obj.name != null)
		assert(save_obj.enabled != null)
		
		assert(obj_save_names.find(save_obj.name)  == -1)
		obj_save_names.append(save_obj.name)
		
		level_state.object_states.append(save_obj.get_state())
	
	assert(level_state.object_states.size() == save_objs.size())
	return level_state

func load_level_state(level_state : Resource):
	if(level_state):
		print("Loading " + str(save_objs.size()) + " savable object datas")
		
		if(save_objs.size() > 0):
			for obj_state in level_state.object_states:
				var found = false
				
				for save_obj in save_objs:
					if(save_obj.name == obj_state.name):
						save_obj.load_state(obj_state)
						found = true
						break
				
				assert(found == true)
