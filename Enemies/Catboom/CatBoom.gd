extends CharacterBody2D

@onready var anim = $AnimationPlayer
@onready var player = get_parent().get_node("Player")
@onready var selfSprite = $Sprite2D
@onready var timer = $Timer
@onready var _particle = preload("res://Enemies/Catboom/Assets/death.tscn")

var RADIUS = 180
var EXPLODEWHEN = 50
var exploded = false

var speed = 50
var vector_to_player
# Called when the node enters the scene tree for the first time.
func _ready():
	anim.play("idle")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Calculate the vector from the enemy to the player
	vector_to_player = player.position - self.position

	# Check if the player is to the left or right
	if player.position.distance_to(self.position) < RADIUS and !exploded:
		self.position += (player.position - self.position).normalized() * delta * speed
		if vector_to_player.x < 0:
			selfSprite.flip_h = true
			anim.play("jog")
		else:
			selfSprite.flip_h = false
			anim.play("jog")
		
		if player.position.distance_to(self.position) < EXPLODEWHEN and !exploded:
			exploded = true
			explode()
		
	if exploded:
		self.position += (player.position - self.position).normalized() * delta * speed * 2

	move_and_slide()
		

func explode():
	timer.start()
	anim.play("jump")

func _on_timer_timeout():
	var particle = _particle.instantiate()
	particle.position = global_position
	particle.rotation = global_rotation
	particle.emitting = true
	get_tree().current_scene.add_child(particle)
	self.queue_free()