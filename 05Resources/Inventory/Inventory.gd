extends Resource
class_name Inventory

export (String) var player_name = ""
export (int) var Money = 0 #aka coins
export (int) var Potions = 0
export (int) var Keys = 0
export (Array, Resource) var Collected = []
export (Array, Resource) var Items = [] #unused atm
export (int) var playerlevel = 1
export (int) var current_health = 10
export (int) var max_health = 10
export (int) var damage = 2
export (Array, Resource) var StatePrizes = []
