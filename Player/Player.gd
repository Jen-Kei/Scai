extends CharacterBody2D

class_name Player 

signal stamina_decrease
signal stamina_increase


# Initialise vars 
@onready var speed = %StatBank.speed
@onready var normal_speed = %StatBank.normal_speed
@onready var extra_speed = %StatBank.extra_speed
@onready var stamina = %StatBank.stamina
@onready var current_direction = "none"
@onready var running = false



# Called when the node enters the scene tree for the first time.
func _ready():
	# Character initial 
	$AnimatedSprite2D.play("front_idle")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	player_speed()
	player_movement(delta)


"""
	FUNCTIONS
	player_movement() - moving the character
	player_speed() - change the speed of the character if walking or running
	player_animation() - changing the animations based on if the character is idle or moving and the direction it's facing
"""

# Move the character and update animation
func player_movement(delta):
	# Character is moving (ugly)?
	if (Input.is_action_pressed("ui_up") || 
		Input.is_action_pressed("ui_down") || 
		Input.is_action_pressed("ui_left") || 
		Input.is_action_pressed("ui_right") ||
		Input.is_action_pressed("ui_run")):

		# Move the player in a direction
		if Input.is_action_pressed("ui_up"):
			current_direction = "up"
			player_animation(1)
			self.transform.origin.y -= speed * delta

		if Input.is_action_pressed("ui_down"):
			current_direction = "down"
			player_animation(1)
			self.transform.origin.y += speed * delta

		if Input.is_action_pressed("ui_left"):
			current_direction = "left"
			player_animation(1)
			self.transform.origin.x -= speed * delta
			
		if Input.is_action_pressed("ui_right"):
			current_direction = "right"
			player_animation(1)
			self.transform.origin.x += speed * delta

	# Character is not moving
	else:
		player_animation(0)
		

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
	

