extends Node2D

# LOAD SCENES
var room = preload("res://Room/Room.gd")

# VARIABLES
@export var tileSize = 16
@export var numRooms = 50
@export var minSize = 4
@export var maxSize = 10


# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()	# initialise random number generator
	make_rooms()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


# FUNCTIONS
# Randomly generate rooms
func make_rooms():
	# Generate all rooms and give them their position, room number, width and height
	for i in range(numRooms):
		var pos = Vector2(0,0)
		var roomNo = room.instantiate()
		var width = minSize + randi() % (maxSize - minSize)
		var height = minSize + randi() % (maxSize - minSize)
		roomNo.make_room(pos, Vector2(width, height) * tileSize) # call function to generate room
		$Rooms.add_child(roomNo) # add newly generated room to rooms container

	

