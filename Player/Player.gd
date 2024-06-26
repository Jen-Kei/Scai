extends CharacterBody2D

class_name Player 

signal stamina_decrease
signal stamina_increase

signal health_decrease
signal health_increase

@onready var staminaBar = $StaminaBar/TextureProgressBar

# Initialise vars 
	
#@onready var speed = %StatBank.speed
#@onready var normal_speed = %StatBank.normal_speed
#@onready var extra_speed = %StatBank.extra_speed
#
#@onready var stamina = %StatBank.stamina
#@onready var current_direction = "none"
#@onready var running = false
#
#@onready var health = %StatBank.health
#@onready var health_capacity = %StatBank.health_capacity
#@onready var health_gain = %StatBank.health_gain

@onready var input_movement = Vector2.ZERO
@onready var animTree = $AnimationTree
@onready var animPlayer = $AnimationPlayer
@onready var animState = animTree.get("parameters/playback")
@onready var inventoryPopup = preload("res://HUD/InventorySelect.tscn")
@onready var camera = preload("res://Camera/Camera.tscn").instantiate()

var inventoryOpen = false

#@onready var DungeonMapZero = preload("res://DungeonMapZero/DungeonMapZero.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	BackgroundMusicPlayer.play_background_music()
	for i in $Marker2D/lights.get_children():
		i.visible = false
	
	get_tree().root.add_child(camera)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	player_speed()
	player_movement()

	if Input.is_action_just_pressed("flashlight"):
		for i in $Marker2D/lights.get_children():
			i.visible = !i.visible


#func reInit():
#	# Initialise vars
#	speed = %StatBank.speed
#	print("Reinit speed: ", speed)
#	normal_speed = %StatBank.normal_speed
#	extra_speed = %StatBank.extra_speed
#
#	stamina = %StatBank.stamina
#	current_direction = "none"
#	running = false
##
#	health = %StatBank.health
#	health_capacity = %StatBank.health_capacity
#	health_gain = %StatBank.health_gain
#
	#staminaBar.staminaPerSecond = %StatBank.stamina_gain


# Move the character and update animation
func player_movement():
	input_movement = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")

	if input_movement != Vector2.ZERO:
		animTree.set("parameters/Idle/blend_position", input_movement)
		animTree.set("parameters/Walk/blend_position", input_movement)

		animState.travel("Walk")

		velocity = input_movement * Globals.currentSpeed 
	
	if input_movement == Vector2.ZERO:
		animState.travel("Idle")
		velocity = Vector2.ZERO

	# for testing, delete if found
	if Input.is_action_just_pressed("inventory") and !inventoryOpen:
		inventoryOpen = true
		var inventory = inventoryPopup.instantiate()
		get_parent().add_child(inventory)

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
		health_increase.emit()


'''
func door_open():
	# Check if the player is near a door
	# For every door, check if the player is near it, if so, hide the door
	for doorCell in DungeonMapZero.get_used_cells(4):
		if self.position.distance_to(DungeonMapZero.local_to_map(doorCell)) < 50:
			if Input.is_action_pressed("interact"):
				print("hide")
'''

func player():
	pass
