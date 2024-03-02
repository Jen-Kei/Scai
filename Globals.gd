extends Node

# VARIABLES
var currentScene = "Forest"
var transitionScene = false

var playerExitDungeonPosX = 0
var playerExistDungeonPosY =0
var playerStartPosX = 0
var playerStartPosY = 0

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
		currentScene = "Dungeon"
	else:
		currentScene = "Forest"