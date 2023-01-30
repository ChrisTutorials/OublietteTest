extends Node
#global player display / stat states.gd #autoload

var playerlevel = 1
var current_health = 10
var max_heatlh = 10
var damage = 3

var maxcoins = 10 #havent used these yet
var maxpotions = 5
var maxkeys = 1


export (int) var coin_number = 0
export (int) var potion_number = 0
export (int) var keys = 0

func _ready():
	pass

func _process(delta): #link state with inventory
	pass

