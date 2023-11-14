extends Control #battle,gd
const CHAR_READ_RATE = 0.075
signal textbox_closed
export(Resource) var enemy = null
#export(Resource) var helditem = null
var current_player_health = 0
var current_enemy_health = 0
var defend = false
signal kappawin

export(String, FILE) var destination_level
export(String) var destination_spawn

func _ready():
	set_health($EnemyContainer/ProgressBar,enemy.hp,enemy.hp)
	set_health($ActionsPanel/PlayerData/ProgressBar, State.current_health, State.max_heatlh)
	$EnemyContainer/enemy.texture = enemy.texture
	current_enemy_health = enemy.hp
	
	current_player_health = State.current_health

	$Textbox.hide()
	$ActionsPanel/Actions.hide()
	display_text("%s is here!" % enemy.name)
	yield(self, "textbox_closed")
	$ActionsPanel/Actions.show()
	yield(get_tree().create_timer(0.5), "timeout")
	$ActionsPanel/Actions/Fight.grab_focus()

func set_health(progress_bar, health, max_health):
	progress_bar.value = health
	progress_bar.max_value = max_health
	progress_bar.get_node("Label").text = "%d/%d" % [health, max_health]

func _input(_event):
	if (Input.is_action_just_pressed("ui_accept") and $Textbox.visible):
		$Textbox.hide()
		emit_signal("textbox_closed")

func display_text(text):
	$Textbox.show()
	$Textbox/Label.text = text
	$Textbox/Label.percent_visible = 1
	#$Tween.interpolate_property($Textbox/Label, "percent_visible", 0.0, 1.0, len(text) * CHAR_READ_RATE, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	#$Tween.start()

func enemy_turn():
	if defend:
		display_text("%s is feeling friendly ..." % enemy.name)
		yield(self, "textbox_closed")
		yield(get_tree().create_timer(0.5), "timeout")
		$ActionsPanel/Actions/Fight.disabled = false
		$ActionsPanel/Actions/Item.disabled = false
		defend = false
	else:
		display_text("%s Strikes!" % enemy.name)
		yield(self, "textbox_closed")
		current_player_health = max(0, current_player_health - enemy.dmg)
		set_health($ActionsPanel/PlayerData/ProgressBar, current_player_health, State.max_heatlh)
		State.current_health -= enemy.dmg
		$AnimationPlayer.play("player_damaged")
		$DamageSound.play()
		yield($AnimationPlayer, "animation_finished")
		display_text("%s damage!" % enemy.dmg)
		yield(self, "textbox_closed")
		if current_player_health == 0:
			yield(get_tree().create_timer(0.5), "timeout")
			display_text("You died!")
			yield(self, "textbox_closed")
			$Goblin.hide()
			yield(get_tree().create_timer(1), "timeout")
			$AnimationPlayer.play("exit_battle")
			yield($AnimationPlayer, "animation_finished")
			State.current_health = State.max_heatlh
			GameManager.load_game()
		elif current_player_health > 0:
			yield(get_tree().create_timer(0.5), "timeout")
			$ActionsPanel/Actions/Fight.disabled = false
			$ActionsPanel/Actions/Talk.disabled = false
			$ActionsPanel/Actions/Item.disabled = false
			defend = false

func _on_Exit_pressed():
	$ActionsPanel/Actions/Exit.disabled = true
	display_text("Bye!")
	yield(self, "textbox_closed")
	yield(get_tree().create_timer(.5), "timeout")
	$EnemyContainer.hide()
	yield(get_tree().create_timer(1), "timeout")
	$AnimationPlayer.play("exit_battle")
	yield($AnimationPlayer, "animation_finished")
	State.current_health = State.max_heatlh
	GameManager.load_level(destination_level, destination_spawn)

func _PotionUse():
	if State.potion_number >= 1:
		State.potion_number -= 1
		$ItemSound.play()
		display_text("Used a potion!")
		current_player_health = max(0, current_player_health + 4)
		set_health($ActionsPanel/PlayerData/ProgressBar, current_player_health, State.max_heatlh)
		yield(self, "textbox_closed")
		yield(get_tree().create_timer(0.5), "timeout")
		enemy_turn()
	else:
		display_text("Out of Potions!")
		yield(self, "textbox_closed")
		yield(get_tree().create_timer(0.5), "timeout")
		enemy_turn()

func _on_Item_pressed():
	$ActionsPanel/Actions/Item.disabled = true
	_PotionUse()

func _on_Fight_pressed():
	$ActionsPanel/Actions/Fight.disabled = true
	display_text("Goblin Punch!")
	yield(self, "textbox_closed")
	current_enemy_health = max(0, current_enemy_health - State.damage)
	set_health($EnemyContainer/ProgressBar, current_enemy_health, enemy.hp)
	$AnimationPlayer.play("enemy_damaged")
	$DamageSound.play()
	yield($AnimationPlayer, "animation_finished")
	display_text("%d damage!" % State.damage)
	yield(self, "textbox_closed")
	if current_enemy_health == 0:
		display_text("%s: %s" % [enemy.name, enemy.death])
		yield(self, "textbox_closed")
		display_text("%s Dies!" % enemy.name)
		yield(self, "textbox_closed")
		$AnimationPlayer.play("enemy_damaged")
		yield($AnimationPlayer, "animation_finished")
		$EnemyContainer.hide()
		yield(get_tree().create_timer(1), "timeout")
		$AnimationPlayer.play("exit_battle")
		yield($AnimationPlayer, "animation_finished")
		State.current_health = State.max_heatlh
		#GameManager.load_game()
		get_tree().change_scene_to(load('res://02test/Gachapon/Gatchapon.tscn'))
	elif current_enemy_health > 0:
		yield(get_tree().create_timer(0.5), "timeout")
		enemy_turn()

func _on_Talk_pressed():
	$ActionsPanel/Actions/Talk.disabled = true
	defend = true
	display_text("Wait!")
	yield(self, "textbox_closed")
	display_text("%s: %s" % [enemy.name, enemy.reply])
	yield(self, "textbox_closed")
	display_text("%s" % enemy.reply2)
	yield(self, "textbox_closed")
	yield(get_tree().create_timer(0.5), "timeout")
