extends Control

var forestScene = "res://Forest/Forest.tscn"
@onready var healthBar = get_tree().root.get_node("PlayerX").get_node("Control").get_node("HealthBar").get_node("TextureProgressBar")
@onready var timer = get_tree().root.get_node("PlayerX").get_node("MyTimer").get_node("Timer")
@onready var player = get_tree().root.get_node("PlayerX")


func pause():
	get_tree().paused = true

func unpause():
	get_tree().paused = false
	

# Called when the node enters the scene tree for the first time.
func _ready():
	self.hide()
	healthBar.game_over.connect(_on_game_over)
	timer.game_over.connect(_on_game_over)
	timer.game_won.connect(_on_game_won)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_the_BTN_pressed():
	var forestGameScreen =  get_tree().root.get_node("Forest").get_node("GameOverScreen")
	var townGameScreen =get_tree().root.get_node("Town").get_node("GameOverScreen")
	var dungeonGameScreen = get_tree().root.get_node("DungeonZero").get_node("GameOverScreen")

	if %GameStatusLabel.text == "Game Over" or %GameStatusLabel.text == "You Win!":
		get_tree().quit()
	else:
		Globals.day += 1
		timer.get_node("timeLabel").text = str("Day: ", Globals.day)

		forestGameScreen.hide()
		townGameScreen.hide()
		dungeonGameScreen.hide()

		get_tree().change_scene_to_file(forestScene)
		player.position = Globals.playerStartPos
		unpause()
		timer.wait_time = 10
		timer.start()
		



#func _on_restart_btn_pressed():
#	# restart the game by sending user to the first scene and deleting all the other nodes?
#	get_tree().root.get_node("PlayerX").get_node("Inventory").queue_free()
#	get_tree().root.get_node("Town").queue_free()
#	get_tree().root.get_node("Forest").queue_free()
#	get_tree().root.get_node("DungeonZero").queue_free()
#	Globals.reinitGlobals()
#	get_tree().change_scene_to_file(mainMenu)
#
#	self.hide()
#	unpause()

func _on_game_over():
	self.show()
	%GameOverMessageLabel.text = str(Globals.gameOverMessage)
	pause()


func _on_game_won():
	self.show()
	if Globals.day < 2:
		%GameStatusLabel.text = "Quota met"
		%theBTN.text = "Start Next Day"
		%GameOverMessageLabel.text = "You're pretty good at this! On to day 2 :>"
		pause()
	else:
		%GameStatusLabel.text = "You Win!"
		%theBTN.text = "Quit"
		%GameOverMessageLabel.text = "That's all we have for you now, thanks for playing!"
