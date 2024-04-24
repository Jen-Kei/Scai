extends Node

# VARIABLES
var currentScene = "Forest"
var transitionScene = false

var playerExitDungeonPos = Vector2(1078 ,105)
var playerStartPos = Vector2(62, 387)

var gameFirstLoadIn = true

var moneyAmount = 50
var day = 1
var quota = 150

# Player stats
@onready var normalSpeed = 100.0
@onready var runSpeed = 200.0
@onready var currentSpeed = normalSpeed

@onready var maxHealth = 500.0
@onready var currentHealth = maxHealth
@onready var healthGain = 0.01

@onready var maxStamina = 500.0
@onready var currentStamina = maxHealth
@onready var staminaGain = 10.0

@onready var fireRate = 10.0


# Called when the node enters the scene tree for the first time.



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

#func finish_change_scenes():
	# reset transition var
#	if transitionScene == true:
#		transitionScene = false

#	if currentScene == "Forest":
#		currentScene = "DungeonZero"
#
#	if currentScene == "DungeonZero":
#		currentScene = "Forest"
#	else:
#		currentScene = "Boo womp"

func reinitGlobals():
	normalSpeed = 100.0
	runSpeed = 200.0
	currentSpeed = normalSpeed
	maxHealth = 500.0
	currentHealth = maxHealth
	healthGain = 0.01
	maxStamina = 500.0
	currentStamina = maxHealth
	staminaGain = 10.0
	fireRate = 10.0