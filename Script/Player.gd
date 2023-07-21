extends KinematicBody2D
#Player.gd
class_name Player

export(String) var player_name = "Player1"
export (float) var speed = 25
export(Resource) var inventory
export(NodePath) onready var audio_player = get_node(audio_player)

func _ready():
	GameManager.active_player = self
	load_state(GameManager.game_data.item_state)

func _process(_delta):
	
	if Input.is_action_pressed("Run"):
		speed = 50
	if Input.is_action_just_released("Run"):
		speed = 25

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
	var item_state = ItemState.new()
	item_state.player_name = player_name
	item_state.player_inventory = inventory
	return item_state

func load_state(item_state : Resource):
	if(item_state):
		#player_name = item_state.player_name
		inventory = item_state.player_inventory #just .inventory?
		State.coin_number = inventory.Money
		State.potion_number = inventory.Potions
		State.keys = inventory.Keys
		print("player/item state loaded")
