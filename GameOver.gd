extends Control


@onready var healthBar = get_tree().root.get_node("PlayerX").get_node("Control").get_node("HealthBar")

func pause():
	get_tree().paused = true

func unpause():
	get_tree().paused = false
	

# Called when the node enters the scene tree for the first time.
func _ready():
	self.hide()
	healthBar.get_node("TextureProgressBar").game_over.connect(_on_game_over)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_quit_btn_pressed():
	get_tree().quit()


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
	pause()
