extends Resource
#GameData.gd
class_name GameData

export(String) var current_level
export(String) var load_position
export(Resource) var inventory
export(Array, Resource) var level_states

func _init(saved : Resource = null):
	if(saved != null):
		current_level = saved.p_current_level
		load_position = saved.p_load_position
		inventory = Inventory.new(saved.inventory)
		level_states = saved.p_level_states
