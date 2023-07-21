extends CanvasLayer

func scenefade():
	get_tree().paused = true
	$Sound.play()
	$Black.show()
	yield(get_tree().create_timer(0.5), "timeout")
	$Black.hide()
	get_tree().paused = false

func battlefade():
	$Sound.play()
	get_tree().paused = true
	$Black.show()
	yield(get_tree().create_timer(0.5), "timeout")
	$Black.hide()
	get_tree().paused = false
