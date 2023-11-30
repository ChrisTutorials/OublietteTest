extends AudioStreamPlayer2D

#loop the audio stream 

onready var audio_player = self

func _on_BGM_finished():
	self.play()
