extends CanvasLayer
#OnscreenKeyboard
var keys_visible = false

func _ready():
	$Control.hide()
	$Keys.hide()
	$InputX.hide()
	$InputY.hide()

func set_on_screen_input_vector(vec):
	$InputX.text = "x: " + str(stepify(vec.x, 0.1))
	$InputY.text = "y: " + str(stepify(vec.y, 0.1))

func _input(_event):
	if Input.is_action_just_pressed("ToggleArrows"):
		if keys_visible:
			keys_visible = false
			$Control.hide()
			$Keys.hide()
			$InputX.hide()
			$InputY.hide()
		elif !keys_visible:
			keys_visible = true
			$Control.show()
			$Keys.show()
			$InputX.show()
			$InputY.show()

func _process(_delta):
	$Control/MoneyCount/MoneyLabel.text = String(State.coin_number)
	$Control/HPCount/CurrentHP.text = String(State.current_health)
	
	if Input.is_action_just_pressed("up"):
		$Keys/Up.frame = 1
	elif Input.is_action_just_released("up"):
		$Keys/Up.frame = 0
	
	if Input.is_action_just_pressed("down"):
		$Keys/Down.frame = 1
	elif Input.is_action_just_released("down"):
		$Keys/Down.frame = 0
	
	if Input.is_action_just_pressed("left"):
		$Keys/Left.frame = 1
	elif Input.is_action_just_released("left"):
		$Keys/Left.frame = 0
	
	if Input.is_action_just_pressed("right"):
		$Keys/Right.frame = 1
	elif Input.is_action_just_released("right"):
		$Keys/Right.frame = 0
