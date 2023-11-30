extends Control

#list ui testing
#boolean note: using !name is the INVERSE of something

var collectedPrizes = State.StatePrizes

var is_pause_active = false

onready var music_bus = AudioServer.get_bus_index("Music")

func _ready():
	$CanvasLayer.hide()
	$CanvasLayer/Tree/TreasureList.clear()

func _input(_event):
	if Input.is_action_just_pressed("List"):
		var is_tree_paused = get_tree().paused
		if is_tree_paused and !is_pause_active:
			return
		elif is_tree_paused and is_pause_active:
			get_tree().paused = false
			is_pause_active = false
			$CanvasLayer.hide()
			print("unpaused")
		elif !is_tree_paused and !is_pause_active:
			is_pause_active = true
			get_tree().paused = true
			$CanvasLayer.show()
			print("paused")

func _process(_delta):
	updateList()

func updateList():
	$CanvasLayer/Tree/TreasureList.clear()
	for prize in collectedPrizes:
		$CanvasLayer/Tree/TreasureList.add_item(prize)

func _on_ItemList_item_activated(index):
	if index == 0:
		Textbox.queue_text("Heals 5 HP")
		get_tree().paused = false
		is_pause_active = false
		$CanvasLayer.hide()
		print("unpaused")
	if index == 1:
		Textbox.queue_text("The Orb swirls with ethereal mist ...")
		get_tree().paused = false
		is_pause_active = false
		$CanvasLayer.hide()
		print("unpaused")
	if index == 2:
		Textbox.queue_text("Small key carved out of iron. Some doors require more than one key.")
		get_tree().paused = false
		is_pause_active = false
		$CanvasLayer.hide()
		print("unpaused")
	if index == 3:
		Textbox.queue_text("Popular childrens toy made into a fruit.")
		get_tree().paused = false
		is_pause_active = false
		$CanvasLayer.hide()
		print("unpaused")
	if index == 4:
		Textbox.queue_text("Typical dungeon coin. Used to barter with demon thane, they are coveted by profane scholars.")
		get_tree().paused = false
		is_pause_active = false
		$CanvasLayer.hide()
		print("unpaused")
	if index == 5:
		Textbox.queue_text("It seems kind of silly to carry around a barrel, but this one has a nice blue paint job!")
		get_tree().paused = false
		is_pause_active = false
		$CanvasLayer.hide()
		print("unpaused")

func _on_TreasureList_item_activated(_index):
	pass


func _on_MusicSlider_value_changed(value):
	AudioServer.set_bus_volume_db(music_bus, linear2db(value))
	AudioServer.set_bus_mute(music_bus, value < .05)
