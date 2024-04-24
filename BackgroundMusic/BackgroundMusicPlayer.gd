extends AudioStreamPlayer

const backgroundMusic = preload("res://BackgroundMusic/Scai.wav") 

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _play_music(music: AudioStream, volume = 5.0):
	if stream == music:
		return

	stream = music
	volume_db = volume
	play()
	print("pllay musc")

func play_background_music():
	_play_music(backgroundMusic)
