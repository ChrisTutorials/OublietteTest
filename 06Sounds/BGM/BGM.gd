extends AudioStreamPlayer2D


#loop the audio stream 
func _on_AudioStreamPlayer2D_finished():
	self.play()
