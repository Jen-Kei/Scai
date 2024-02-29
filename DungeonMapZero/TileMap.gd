extends TileMap

@onready var player = get_tree().root.get_child(0).get_node("Player")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	door_open()

func door_open():
	# Check if the player is near a door
	# For every door, check if the player is near it, if so, hide the door
	for doorCell in self.get_used_cells(4):
		if player.position.distance_to(self.map_to_local(doorCell)) < 50:
			if Input.is_action_pressed("interact"):
				self.set_cell()
			else:

