class_name Player extends CharacterBody2D

# Movement
var input_movement = Vector2.ZERO

# Signals
signal stamina_decrease
signal stamina_increase
signal health_decrease
signal health_increase

# References to other nodes
@onready var animPlayer = get_tree().root.get_child(2).get_child(0).get_node("AnimPlayer")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	player_movement(delta)
	player_speed()

# Move the character and update animation
func player_movement(delta):
	var animTree = $AnimationTree
	var animState = animTree.get("parameters/playback")
	input_movement = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")

	if input_movement != Vector2.ZERO:
		animTree.set("parameters/Idle/blend_position", input_movement)
		animTree.set("parameters/Walk/blend_position", input_movement)

		animState.travel("Walk")

		velocity = input_movement * Globals.currentSpeed
	
	if input_movement == Vector2.ZERO:
		animState.travel("Idle")
		velocity = Vector2.ZERO
		
	move_and_slide()

# Change the player's speed and update the stamina meter 
func player_speed():
	if Input.is_action_pressed("ui_run") && Globals.currentStamina > 10:
		print("running")
		if Globals.currentStamina > 30:
			Globals.currentSpeed = Globals.runSpeed
			animPlayer.speed_scale = 1.5
		stamina_decrease.emit()
	else:
		Globals.currentSpeed = Globals.normalSpeed
		animPlayer.speed_scale = 1
		stamina_increase.emit()
