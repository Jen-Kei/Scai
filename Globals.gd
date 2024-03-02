extends Node

# VARIABLES
var currentScene
var transitionScene = false

var playerExitDungeonPos = Vector2(1078 ,105)
var playerStartPos = Vector2(62, 387)

var gameFirstLoadIn = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func finish_change_scenes():
	# reset transition var
	if transitionScene == true:
		transitionScene = false

	if currentScene == "Forest":
		currentScene = "DungeonZero"

	if currentScene == "DungeonZero":
		currentScene = "Forest"
	else:
		currentScene = "Boo womp"