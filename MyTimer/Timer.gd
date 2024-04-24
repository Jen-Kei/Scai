extends Timer

var secs
var mins

signal game_over
signal game_won

# Called when the node enters the scene tree for the first time.
func _ready():
	one_shot = true
	wait_time = 5
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
	if Globals.moneyAmount < Globals.quota:
		Globals.gameOverMessage = "You failed to reach the quota in time."
		game_over.emit()
	else:
		game_won.emit()
		#wait_time = 10
		#start()

	
	
