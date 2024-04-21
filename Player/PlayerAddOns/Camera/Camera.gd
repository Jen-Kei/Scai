extends Camera2D


# Called when the node enters the scene tree for the first time.
@onready var player = get_tree().root.get_child(0).get_node("Player")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	transform.origin = player.transform.origin 
	#offset = Vector2(-player.position)
