extends RigidBody2D

# VARIABLES
var size	# size of the room 

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


# FUNCTIONS
# Generate a room
func make_room(_pos, _size):
	# VARIABLES
	var s = 0
	position = _pos
	size = _size

	# Genrate collision shapes for the rooms
	s = RectangleShape2D.new()
	s.extents = size
	$CollisionShape2D.shape = s
	
