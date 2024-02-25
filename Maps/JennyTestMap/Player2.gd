extends CharacterBody2D

class_name Player2 

signal stamina_decrease
signal stamina_increase

signal health_decrease
signal health_increase


# Initialise vars 
var speed = 50
var normal_speed = 50
var extra_speed = 100


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("ui_right"):
		self.transform.origin.x += speed * delta
	if Input.is_action_pressed("ui_left"):
		self.transform.origin.x -= speed * delta
	if Input.is_action_pressed("ui_up"):
		self.transform.origin.y -= speed * delta
	if Input.is_action_pressed("ui_down"):
		self.transform.origin.y += speed * delta

	move_and_slide()

