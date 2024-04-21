extends CharacterBody2D


var input_movement = Vector2.ZERO


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	player_movement(delta)

# Move the character and update animation
func player_movement(delta):
	var speed = 50
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
