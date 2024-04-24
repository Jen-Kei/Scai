extends Timer

var secs
var mins

# Called when the node enters the scene tree for the first time.
func _ready():
	one_shot = true
	wait_time = 600
	start()
	%timeLabel.text = str("Day: ", Globals.day)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# turn into a clock
	if time_left > 0:
		secs = int(time_left) % 60
		mins = int(time_left) / 60
		if secs < 10:
			%clockLabel.text = str(mins, ":", 0, secs )
		else:
			%clockLabel.text = str(mins, ":", secs)
	else:
		on_timer_timeout()

func on_timer_timeout():
	stop()
	%clockLabel.text = "!:!!"

	
	