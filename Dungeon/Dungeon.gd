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
var fin

# VARIABLES FOR CORRIDOR GENERATION
var path # AStar2d pathfinding object
var roomPositions = []
@onready var Map = $TileMap

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
	# Reset variable values
	roomsFiltered = 0
	roomPositions = []
	fin = false

	# Delete previously generated rooms before generating new rooms
	for room in $Rooms.get_children():
		room.queue_free()

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
	
	fin = true
	if fin == true && path:
		make_map()
	else:
		make_rooms()

func _draw():
	'''
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
		'''
	
				


	

# Delete the rooms and make new rooms
func _input(event):
	# Check if user presses select key
	if event.is_action_pressed("ui_select"):

		make_rooms()
'''
	# Check if user presses next key
	if event.is_action_pressed("ui_make_map"):
		make_map()
'''

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
	fin = false

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
			Map.set_cell(0, Vector2i(x, y), 1, Vector2i(8, 7), 0)
			
	
	# Carve the rooms & corridors
	# For each room, get the size of the room 
	var corridors = [] # Keep track of corridors created so only one corridor per connection
	var p
	for room in $Rooms.get_children():
		var s = (room.size / tileSize).floor()
		var _pos = Map.local_to_map(room.position)
		var ul = (room.position / tileSize).floor() - s
		var start
		var end

		# Start at 2 to get border
		for x in range(0, s.x * 2 - 1):
			for y in range(0, s.y * 2 - 1):
				#Map.set_cell(0, Vector2i(ul.x + x, ul.y + y), 0, Vector2i(2, 2), 0)
				Map.set_cells_terrain_connect(1, [Vector2i(ul.x + x, ul.y + y)], 0, 0, false)
		
		# Carve connecting corridor
		p = path.get_closest_point(room.position) # !!THIS LINE IS  A PROBLEM I THINK!

		for conn in path.get_point_connections(p):
			if not conn in corridors:
				start = Map.local_to_map(Vector2(path.get_point_position(p).x, path.get_point_position(p).y))
				end = Map.local_to_map(Vector2(path.get_point_position(conn).x, path.get_point_position(conn).y))
	
		# Carve a path from start to end
		carve_path(start, end)
	corridors.append(p)


	print("before fin")
	fin = true
	while fin == false:
		pass
	print("after fin")

	var cells = Map.get_used_cells(1)
	print("make walls")
	for tilePosition in cells:
		print("entered for")
		if Map.get_cell_source_id(1, tilePosition) != -1:
			print("first if")
			if Map.get_cell_source_id(1, Vector2i(tilePosition.x, tilePosition.y - 1)) == -1:
				print("second if")
				Map.set_cells_terrain_connect(1, [Vector2i(tilePosition.x, tilePosition.y)], 0, 1, false)
	

	

# carve_path IS being called on every connection
func carve_path(start, end):
	var difference_x = sign(end.x - start.x)
	var difference_y = sign(end.y - start.y)
	
	if difference_x == 0:
		difference_x = pow(-1.0, randi() % 2)
	if difference_y == 0:
		difference_y = pow(-1.0, randi() % 2)
		
	var x_over_y = start
	var y_over_x = end
	
	if randi() % 2 > 0:
		x_over_y = end
		y_over_x = start

	# Carving path
	print("Carving path")
	for x in range(start.x, end.x + difference_x, difference_x):
		Map.set_cells_terrain_connect(1, [Vector2i(x, x_over_y.y)], 0, 0, false)
	
	for y in range(start.y, end.y + difference_y, difference_y):
		Map.set_cells_terrain_connect(1, [Vector2i(y_over_x.x + difference_x, y)], 0, 0, false)


		
