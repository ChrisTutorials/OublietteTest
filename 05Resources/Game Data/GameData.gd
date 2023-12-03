extends Resource
#GameData.gd
class_name GameData

export(String) var current_level 
export(String) var load_position
export(Resource) var inventory = Inventory.new()
export(Array, Resource) var level_states = []
