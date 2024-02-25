extends RigidBody2D

# VARIABLES
var size	# size of the room 


# FUNCTIONS
'''
# Input parameters: Room position and size to generate a room
# Generates a RectangleShape2D node, and then generates a collision shape with that rectangle2D node
'''
func make_room(_pos, _size):
	# VARIABLES
	var shape = 0
	position = _pos
	size = _size

	# Make a rectagle shape 
	shape = RectangleShape2D.new()
	shape.custom_solver_bias = 0.75 # make the rooms spread apart from each other faster
	shape.extents = size
	$CollisionShape2D.shape = shape
	
