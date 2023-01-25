extends CanvasLayer

func scenefade():
	$Black.show()
	$Sound.play()
	yield(get_tree().create_timer(0.25), "timeout")
	$Black.hide()

func battlefade():
	$Black.show()
	$Sound.play()
	yield(get_tree().create_timer(0.25), "timeout")
	$Black.hide()
