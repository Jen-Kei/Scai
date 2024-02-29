extends CharacterBody2D

@onready var AI = preload("res://UIPopup/UIPopup.tscn").instantiate()
@onready var anim = $AnimationPlayer
@onready var player = get_tree().get_root().get_child(0).get_node("Player")
@onready var ekey = $eKey

# Called when the node enters the scene tree for the first time.
func _ready():
	anim.speed_scale = 0.5
	anim.play("idle")
	ekey.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if player.position.distance_to(self.position) < 50:
		ekey.visible = true
		if Input.is_action_just_pressed("interact"):
			print("Popup")
	else:
		ekey.visible = false
