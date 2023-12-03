extends KinematicBody2D
#Player.gd
class_name Player

export(String) var player_name = "Player1"
export(Resource) var inventory

export (float) var speed = 25.00

export(NodePath) onready var audio_player = get_node(audio_player)



func _ready():
	GameManager.active_player = self

	print("player ready")

func _process(_delta):
	
	if Input.is_action_pressed("Run"):
		speed = 50.00
	if Input.is_action_just_released("Run"):
		speed = 25.00

	var velocity = Vector2.ZERO
	if Input.is_action_pressed("left"):
		velocity.x -= 1.0
	if Input.is_action_pressed("right"):
		velocity.x += 1.0
	if Input.is_action_pressed("down"):
		velocity.y += 1.0
	if Input.is_action_pressed("up"):
		velocity.y -= 1.0
	velocity = velocity.normalized()
	
	if velocity == Vector2.ZERO:
		$AnimationTree.get("parameters/playback").travel("Idle")
	else:
		$AnimationTree.get("parameters/playback").travel("Walk")
		$AnimationTree.set("parameters/Idle/blend_position", velocity)
		$AnimationTree.set("parameters/Walk/blend_position", velocity)
		move_and_slide(velocity * speed)
	OnScreenKeyboard.set_on_screen_input_vector(velocity)

func save_state():
	return inventory

func load_state(inventory_state : Resource):
	assert(inventory_state != null)
	inventory = inventory_state

	# Not needed, the state inventory and the player inventory resources are the same	
	#State.coin_number = inventory.Money
	#State.potion_number = inventory.Potions
	#State.keys = inventory.Keys
	#State.collected = inventory.Collected #tracks if items should stay gone if picked up.
	#State.playerlevel = inventory.playerlevel
	#State.current_health = inventory.current_health
	#State.damage = inventory.damage
	#State.max_heatlh = inventory.max_health #some sort of issue with updating
	#State.StatePrizes = inventory.StatePrizes 
	
	print("player instance loaded, state.gd updated.")
