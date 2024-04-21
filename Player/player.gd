extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5

@onready var animTree = $AnimationTree
@onready var animState = animTree.get("parameters/playback")


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if direction:
		# Set the blend position based on the input direction for AnimationTree
		$AnimationTree.set("parameters/Idle/blend_position", input_dir)
		$AnimationTree.set("parameters/Walk/blend_position", input_dir)
		$AnimationTree.get("parameters/playback").travel("Walk")  # Switch to Walk animation

		# Set velocity for movement
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		# If no movement input, switch to Idle animation
		$AnimationTree.get("parameters/playback").travel("Idle")
		
		# Decelerate if no input direction
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()