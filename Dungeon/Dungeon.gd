extends Node2D

# LOAD SCENES
var Room = preload("Room/Room.tscn")

# VARIABLES
@export var tileSize = 16
@export var numRooms = 30
@export var minSize = 4
@export var maxSize = 10
@export var horizontalSpread = 50 
@export var filter = 0.5 # filter var to delete a certain amount of generated rooms


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
		var pos = Vector2(randf_range(-horizontalSpread, horizontalSpread), 0)
		var roomNo = Room.instantiate()
		var width = minSize + randi() % (maxSize - minSize)
		var height = minSize + randi() % (maxSize - minSize)
		roomNo.make_room(pos, Vector2(width, height) * tileSize) # call function to generate room
		$Rooms.add_child(roomNo) # add newly generated room to rooms container
	
		# wait for physics engine to stop spreading apart the rooms
		await(get_tree().create_timer(1.1).timeout) 
		# Loop through every child in the room container and if randomly gen number is less then filter number
		# Delete child
		for room in $Rooms.get_children():
			if randf() < filter:
				room.queue_free()
			else:
				room.freeze = true # Change child so it can't be moved anymore

func _draw():
	# Draw the outline for the rooms
	for room in $Rooms.get_children():
		draw_rect(Rect2(room.position - room.size, room.size * 2), Color(32, 228, 0), false)


# Delete the rooms and make new rooms
func _input(event):
	# Check if user presses select key
	if event.is_action_pressed("ui_select"):
		# Loop thru every child in the room container and delete them
		for room in $Rooms.get_children():
			room.queue_free()
		# Generate new rooms
		make_rooms()