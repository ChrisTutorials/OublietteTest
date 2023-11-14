extends Control


var availablePrizes = ["Tiny Kappa", "Waddle Boy", "Frito Bandito", "Walkie Talkie Cat", "Tiny Potion", "Ankh of Truth", "Gobbledygook Jr.", "Booboo's Pocket Adventure", "Pendant of the Old Tree", "Fish Head Keychain", "Banana Boy", "Fairy Keychain", "Angel Keychain", "Vintage Silver Spoon", "Worm Doll", "Hillbilly Bug", "Goblin Jr.", "Slug Buddy Keychain", "Tiny Weapon #4", "Tiny Weapon #7", "Evil Engine #9", "Looney Burger Keychain", "Grotto Man Keychain"]  # List of available prizes
var collectedPrizes = []  # List to track player's collected prizes
#var tries = 5  # Number of remaining tries

export(String, FILE) var destination_level
export(String) var destination_spawn

func _ready():

	pass

func _process(delta):
	$Panel2/TextureButton/Label.text = String(State.coin_number)
	updateList()

func updateList():
	$ItemPanel/ItemList.clear()
	for prize in collectedPrizes:
		$ItemPanel/ItemList.add_item(prize)


func _on_PayButton_pressed():

	if State.coin_number > 0:
		State.coin_number -= 1  # Decrease the remaining tries
		Textbox.queue_text("Ca-Clunk... PON!")
		Textbox.queue_text("Oh! It's a capsule toy!")
		var obtainedPrize = gachapon_spin()  # Call the method to get a random prize
		collect_prize(obtainedPrize)  # Call the method to handle the obtained prize
		print(collectedPrizes)
		Textbox.queue_text("Inside is ... " + obtainedPrize)
		$Panel2/Label.text = "GASHAPON!!!"


	else:
		Textbox.queue_text("Out of money!")   

func gachapon_spin():
	randomize()
	var randomIndex = randi() % availablePrizes.size()
	return availablePrizes[randomIndex]

func collect_prize(prize):
	collectedPrizes.append(prize)
	State.StatePrizes.append(prize)
	# Update the UI to show the obtained prize and the player's collection
#func update_ui():
	# Update the UI elements with the current values (e.g., number of remaining tries, collected prizes)


func _on_TextureButton_pressed():
	State.coin_number += 1


func _on_Exit_pressed():
	#$Panel2/Label.text = "BYE BYE!"
	SceneChanger.scenefade()
	#GameManager.load_game()
	GameManager.load_level(destination_level, destination_spawn)
	Textbox.queue_text("Press X to view treasures!")


func _on_ItemList_item_activated(index):
	#Textbox.queue_text("One of my prizes.")
	pass
