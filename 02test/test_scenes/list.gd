extends Control

var collectedPrizes = State.StatePrizes

func _ready():
	$CanvasLayer.hide()
	$CanvasLayer/Panel/Tree/TreasureList.clear()
	
func _input(_event):
	if Input.is_action_pressed("List"):
		if $CanvasLayer.visible == false:
			$CanvasLayer.show()
	else:
		$CanvasLayer.hide()

func _process(delta):

	updateList()

func updateList():
	$CanvasLayer/Panel/Tree/TreasureList.clear()
	for prize in collectedPrizes:
		$CanvasLayer/Panel/Tree/TreasureList.add_item(prize)


func _on_ItemList_item_activated(index):
	if index == 0:
		Textbox.queue_text("Heals 5 HP")
	if index == 1:
		Textbox.queue_text("The Orb swirls with ethereal mist ...")
	if index == 2:
		Textbox.queue_text("Small key carved out of iron. They say each door is given it's own key that they are tasked to hide for Lockman.")
	if index == 3:
		Textbox.queue_text("Popular childrens toy made into a fruit.")
	if index == 4:
		Textbox.queue_text("Typical dungeon coin. Used to barter with demon thane, merchants trade them to ritual cultists. Some are fun to collect.")
	if index == 5:
		Textbox.queue_text("It seems kind of silly to carry around a barrel, but this one has a nice blue paint job!")


func _on_Button_pressed():
	$CanvasLayer/Panel/StatPanel/Label2.text = String(SaveTest.player_health)


func _on_TreasureList_item_activated(index):
	pass
