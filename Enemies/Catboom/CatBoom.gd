extends CharacterBody2D

@onready var anim = $AnimationPlayer
@onready var player = $Player
var speed = 100

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if player.position.distance_to(self.position) < 450:
		self.position += (player.position - self.position).normalized() * delta * speed


func _on_timer_timeout():
	pass # Replace with function body.


func _on_re_calc_timer_timeout():
	pass # Replace with function body.
