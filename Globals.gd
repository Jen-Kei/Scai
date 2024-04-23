extends Node


@onready var currentScene = "Town"
# Player stats
@onready var normalSpeed = 100.0
@onready var runSpeed = 200.0
@onready var currentSpeed = normalSpeed

@onready var maxHealth = 500.0
@onready var currentHealth = maxHealth
@onready var healthGain = 10.0

@onready var maxStamina = 500.0
@onready var currentStamina = maxHealth
@onready var staminaGain = 10.0

@onready var fireRate = 10.0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
