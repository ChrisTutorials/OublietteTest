extends Area2D

export(AudioStreamSample) var pickup_sound
export var enabled = true setget set_enabled

func set_enabled(isEnabled : bool):
	if(isEnabled == false):
		_disable_pickup()
	enabled = isEnabled

func _pickup(_player : Player):
	push_error("Not implemented. Write pickup code in extended class")

func _disable_pickup():
	set_deferred("monitorable", false)
	set_deferred("monitoring", false)
	self.visible = false

func _on_Pickup_body_entered(body):
	if(body is Player):
		_pickup(body)
		body.audio_player.stream = pickup_sound
		body.audio_player.play()

func get_state():
	var object_state = ObjectState.new()
	object_state.enabled = enabled
	object_state.name = name
	return object_state

func load_state(state : Resource):
	self.enabled = state.enabled
