extends Node2D

# LOAD SCENES
var Room = preload("Room/Room.tscn")

# VARIABLES FOR ROOM GENERATION
var tileSize = 16
var numRooms = 30
var minSize = 4
var maxSize = 10
var horizontalSpread = 	10
var filter = 0.45 # filter var to delete a certain amount of generated rooms
var roomsFiltered = 0

# VARIABLES FOR CORRIDOR GENERATION
var path # AStar2d pathfinding object
var roomPositions = []
@onready var Map = $TileMap

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()	# initialise random number generator
	make_rooms()
	print(Map)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	queue_redraw() # call draw()


# FUNCTIONS
# Randomly generate rooms
func make_rooms():
	# Reset variable values
	roomsFiltered = 0
	roomPositions = []

	# Generate all rooms' collision shapes and give them their position, room number, width and height
	# Adds the rooms as children to the Room node (container)
	for i in range(numRooms):
		var pos = Vector2(randf_range(-horizontalSpread, horizontalSpread), 0)
		var roomNo = Room.instantiate()
		var width = minSize + randi() % (maxSize - minSize)
		var height = minSize + randi() % (maxSize - minSize)
		roomNo.make_room(pos, Vector2(width, height) * tileSize) # call function to generate room
		$Rooms.add_child(roomNo) # add newly generated room to rooms container
	
	# wait for physics engine to stop spreading apart the rooms
	await(get_tree().create_timer(1.1).timeout) # delay



	# Filter the rooms and delete a few while leaving a minimum amount of rooms (makes them less cluttered)
	for room in $Rooms.get_children():
		# Check if we've already deleted half the trees
		if roomsFiltered >= numRooms/2.0:
			return

		if randf() < filter:
			roomsFiltered += 1
			room.queue_free()
		else:
			room.freeze = true # Change child so it can't be moved anymore
			roomPositions.append(Vector2(room.position.x, room.position.y))

		print("roomsFiltered = ", roomsFiltered)

	# delay so the rooms and positions generate fully
	await(get_tree().create_timer(1.1).timeout) 

	# generate a mininmum spanning tree connecting the rooms
	path = find_mst(roomPositions)

func _draw():
	# Draw the outline for the rooms
	for room in $Rooms.get_children():
		draw_rect(Rect2(room.position - room.size, room.size * 2), Color(32, 228, 0), false)

	# Draw the path
	if path:
		for pointA in path.get_point_ids():
			for pointB in path.get_point_connections(pointA):
				var tempPointA = path.get_point_position(pointA)
				var tempPointB = path.get_point_position(pointB)
				draw_line(tempPointA, tempPointB, Color(1, 1, 0), 15, true)
				


	

# Delete the rooms and make new rooms
func _input(event):
	# Check if user presses select key
	if event.is_action_pressed("ui_select"):
		# Loop thru every child in the room container and delete them
		for room in $Rooms.get_children():
			room.queue_free()
		# Generate new rooms
		make_rooms()

	# Check if user presses next key
	if event.is_action_pressed("ui_make_map"):
		make_map()

# Input parameter: an array containing Vector3's - the positions of each room
# Using AStar2D object, generate a minimum spanning tree with Prim-Dijkstra's algorithm
func find_mst(nodes):
	# VARIABLES
	path = AStar2D.new()
	var minDistance # Minimum distance so far
	var minPosition # Position of that node
	var currPosition # Current position
	var nextId # point ID


	# Add a point to the AStar2D object by popping an element from an array of nodes
	path.add_point(path.get_available_point_id(), nodes.pop_front()) # AStar2D needs an id and vector3

	# Repeat until no more nodes remain (array returns false if empty)
	while nodes:
		minDistance = INF # Min distance so far	
		minPosition = null
		currPosition = null
		

		# Loop through all points in path
		for pointA in path.get_point_ids():
			pointA = path.get_point_position(pointA)

			# Loop through the remaining nodes
			for pointB in nodes:
				if pointA.distance_to(pointB) < minDistance:
					minDistance = pointA.distance_to(pointB)
					minPosition = pointB
					currPosition = pointA
			
		nextId = path.get_available_point_id()
		path.add_point(nextId, minPosition)
		path.connect_points(path.get_closest_point(currPosition), nextId)
		nodes.erase(minPosition)
	return path


# Create a tilemap from the generated rooms and paths
func make_map():
	# VARIABLES

	Map.clear() # Clear any existing tiles so we can regenerate

	# Find out how big to make rect to cover all the rooms
	# Fill tilemap with unwalkable area, then carve empty rooms

	var fullRect = Rect2()

	for room in $Rooms.get_children():
		var r = Rect2(room.position - room.size, room.get_node("CollisionShape2D").shape.extents*2)
		fullRect = fullRect.merge(r)
	var topLeftPos = Map.local_to_map(fullRect.position)
	var bottomRightPos = Map.local_to_map(fullRect.end)

	for x in range(topLeftPos.x, bottomRightPos.x):
		for y in range(topLeftPos.y, bottomRightPos.y):
			Map.set_cell(0, Vector2i(x, y), 1, Vector2i(2, 0), 0)
			
