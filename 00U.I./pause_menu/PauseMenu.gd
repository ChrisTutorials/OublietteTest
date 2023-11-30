extends CanvasLayer
#pause_screen #autoload
var is_pause_active = false


func _ready():
	$Menu.hide()
	$ItemPanel.hide()
	$JournalPanel.hide()
	
	#dialog.dialog_text = "Are you sure you want to Quit?"
	#dialog.get_ok().text = " Yes "
	#dialog.get_cancel().text = " No "
	#dialog.connect("confirmed", self, "end")
	#add_child(dialog)
	#get_tree().set_auto_accept_quit(false)

func _process(_delta):
	
	$ItemPanel/Panel/CoinsCount.text = String(State.coin_number)
	$ItemPanel/Panel/PotionsCount.text = String(State.potion_number)
	$ItemPanel/Panel/KeysCount.text = String(State.keys)
	
	$JournalPanel/JournalBackPanel/PlayerLevel/LevelNum.text = String(State.playerlevel)
	$JournalPanel/JournalBackPanel/HPLabel/HPBoxContainer/HPNum.text = String(State.current_health)
	$JournalPanel/JournalBackPanel/HPLabel/HPBoxContainer/HPMax.text = String(State.max_heatlh)
	$JournalPanel/JournalBackPanel/Damage/DamageNum.text = String(State.damage)



func _input(_event):
	if Input.is_action_just_pressed("ui_pause"):
		var is_tree_paused = get_tree().paused
		if is_tree_paused and !is_pause_active:
			return
		elif is_tree_paused and is_pause_active:
			get_tree().paused = false
			is_pause_active = false
			$Menu.hide()
			$ItemPanel.hide()
			print("unpaused")
			
		elif !is_tree_paused and !is_pause_active:
			
			is_pause_active = true
			get_tree().paused = true
			$Sound.play()
			$Menu.show()
			$Menu/Resume.grab_focus()
			print("paused")

func _on_Quit_pressed():
	$Menu/ColorRect.show()
	$Sound.play()
	yield(get_tree().create_timer(0.5), "timeout")
	get_tree().quit()

func _on_Resume_pressed():
	get_tree().paused = false
	is_pause_active = false
	$Menu.hide()
	$ItemPanel.hide()
	$JournalPanel.hide()
	print("unpaused")

func _on_Items_pressed():
	#fade()
	$Sound.play()
	$ItemPanel.show()

func _on_Journal_pressed():
	#fade()
	$Sound.play()
	$JournalPanel.show()

func load_game():
	GameManager.load_game()
	

func _on_Load_pressed():
	fade()
	load_game()

func fade():
	$Menu/ColorRect.show()
	$Sound.play()
	yield(get_tree().create_timer(0.5), "timeout")
	$Menu/ColorRect.hide()



func end():
	get_tree().quit()
