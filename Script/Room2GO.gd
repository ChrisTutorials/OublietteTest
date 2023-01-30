extends YSort


func _ready():
	$Key.hide()
	$Key.monitorable = false
	$Key.monitoring = false

func _on_Monkey_givekey():
	$Key.show()
	$Key.monitorable = true
	$Key.monitoring = true
