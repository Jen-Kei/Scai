extends CharacterBody2D

class_name Player 

signal stamina_decrease
signal stamina_increase

signal health_decrease
signal health_increase

@onready var staminaBar = $StaminaBar/TextureProgressBar

# Initialise vars 
@onready var speed = %StatBank.speed
@onready var normal_speed = %StatBank.normal_speed
@onready var extra_speed = %StatBank.extra_speed

@onready var stamina = %StatBank.stamina
@onready var current_direction = "none"
@onready var running = false

@onready var health = %StatBank.health
@onready var health_capacity = %StatBank.health_capacity
@onready var health_gain = %StatBank.health_gain

@onready var input_movement = Vector2.ZERO


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	player_speed()
	player_movement()

func reInit():
	# Initialise vars
	speed = %StatBank.speed
	print("Reinit speed: ", speed)
	normal_speed = %StatBank.normal_speed
	extra_speed = %StatBank.extra_speed

	stamina = %StatBank.stamina
	current_direction = "none"
	running = false

	health = %StatBank.health
	health_capacity = %StatBank.health_capacity
	health_gain = %StatBank.health_gain

	staminaBar.staminaPerSecond = %StatBank.stamina_gain

"""
	FUNCTIONS
	player_movement() - moving the character
	player_speed() - change the speed of the character if walking or running
	player_animation() - changing the animations based on if the character is idle or moving and the direction it's facing
"""

# Move the character and update animation
func player_movement():
	var animTree = $AnimationTree
	var animState = animTree.get("parameters/playback")
	input_movement = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")

	if input_movement != Vector2.ZERO:
		animTree.set("parameters/Idle/blend_position", input_movement)
		animTree.set("parameters/Walk/blend_position", input_movement)

		animState.travel("Walk")

		velocity = input_movement * speed 
	
	if input_movement == Vector2.ZERO:
		animState.travel("Idle")
		velocity = Vector2.ZERO

	move_and_slide()


# Change the player's speed and update the stamina meter 
func player_speed():
	if Input.is_action_pressed("ui_run") && stamina > 10:
		speed = extra_speed
		running = true
		stamina_decrease.emit()
	else:
		speed = normal_speed
		running = false
		stamina_increase.emit()

	#print("stamina: ", stamina)


# Change the sprite's animations
func player_animation(movement):
	var direction = current_direction
	var animation = $AnimatedSprite2D


	if direction == "left":
		animation.flip_h = true
		if movement == 1:
			if running == true:
				animation.speed_scale = 3
			else:
				animation.speed_scale = 1
			animation.play("side_walk")
		elif movement == 0:
			animation.play("side_idle")

	if direction == "right":
		animation.flip_h = false
		if movement == 1:
			if running == true:
				animation.speed_scale = 3
			else:
				animation.speed_scale = 1
			animation.play("side_walk")
		elif movement == 0:
			animation.play("side_idle")

	if direction == "up":
		animation.flip_h = false
		if movement == 1:
			if running == true:
				animation.speed_scale = 3
			else:
				animation.speed_scale = 1
			animation.play("back_walk")
		elif movement == 0:
			animation.play("back_idle")

	if direction == "down":
		animation.flip_h = false
		if movement == 1:
			if running == true:
				animation.speed_scale = 3
			else:
				animation.speed_scale = 1
			animation.play("front_walk")
		elif movement == 0:
			animation.play("front_idle")
	

