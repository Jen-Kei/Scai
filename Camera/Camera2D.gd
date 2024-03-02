extends Camera2D


# Called when the node enters the scene tree for the first time.
@onready var player = get_tree().get_root().get_child(0).get_node("Player")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	transform.origin = player.transform.origin 
