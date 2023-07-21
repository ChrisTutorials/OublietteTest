extends Control


var availablePrizes = ["Tiny Kappa", "Waddle Boy", "Jeweled Spirit", "Walkie Talkie Cat", "Tiny Potion", "Ankh of Truth", "Gobbledygook Jr.", "Gorbino's Pocket Adventure", "Talisman of Cruelty", "Fish Head Keychain", "Doctor Mister McDougal", "Misery Fairy", "Angel Soft Doll", "Vintage Sauce Packet", "Worm Food Figurine", "Hillbilly Bug", "Goblin Jr.", "Baby Blankie Bear", "Tiny Weapon #4", "Tiny Weapon #7", "Evil Engine #9", ""]  # List of available prizes
var collectedPrizes = []  # List to track player's collected prizes
var tries = 5  # Number of remaining tries


func _ready():
	pass

func _on_PayButton_pressed():

	if State.coin_number > 0:
		Textbox.queue_text("Ca-Clunk... PON!")
		Textbox.queue_text("Oh! It's a capsule toy!")
		var obtainedPrize = gachapon_spin()  # Call the method to get a random prize
		collect_prize(obtainedPrize)  # Call the method to handle the obtained prize
		State.coin_number -= 1  # Decrease the remaining tries
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
	# Update the UI to show the obtained prize and the player's collection
#func update_ui():
	# Update the UI elements with the current values (e.g., number of remaining tries, collected prizes)


func _on_TextureButton_pressed():
	State.coin_number += 1
