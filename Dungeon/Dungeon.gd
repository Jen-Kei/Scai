extends Node2D

# LOAD SCENES
var Room = preload("res://Room/Room.tscn")

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
	# For every room, 
	for i in range(numRooms):
		var pos = Vector2(0,0)
		var r = Room.instantiate()
		var w = min_size + randi() % (max_size - min_size)
	

