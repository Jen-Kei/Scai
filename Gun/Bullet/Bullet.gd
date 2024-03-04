extends RigidBody2D

func _on_timer_timeout():
	print("Dead bullet")
	queue_free()


func add_audio(body):
	var audio = AudioStreamPlayer2D.new()
	audio.stream = body.get_node("death").stream
	get_tree().root.get_child(0).get_node("AudioPlayer").add_child(audio)
	get_tree().root.get_child(0).get_node("AudioPlayer").get_child(0).play()

func _on_area_2d_body_entered(body):
	if(body.is_in_group("cat")):			
		body.explodeX()
		queue_free() # if zombie
	else:
		print("Not zombie")
		queue_free()
