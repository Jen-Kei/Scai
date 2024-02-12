extends Node2D

# LOAD SCENES
var Room = preload("Room/Room.tscn")

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
	queue_redraw() # call draw()


# FUNCTIONS
# Randomly generate rooms
func make_rooms():
	# Generate all rooms' collission shapes and give them their position, room number, width and height
	for i in range(numRooms):
		var pos = Vector2(0,0)
		var roomNo = Room.instantiate()
		var width = minSize + randi() % (maxSize - minSize)
		var height = minSize + randi() % (maxSize - minSize)
		roomNo.make_room(pos, Vector2(width, height) * tileSize) # call function to generate room
		$Rooms.add_child(roomNo) # add newly generated room to rooms container
	
func _draw():
	# Draw the outline for the rooms
	for room in $Rooms.get_children():
		draw_rect(Rect2(room.position - room.size, room.size * 2), Color(32, 228, 0), false)


func _input(event):
	if event.is_action_pressed("ui_select"):
		for room in $Rooms.get_children():
			room.queue_free()
		make_rooms()