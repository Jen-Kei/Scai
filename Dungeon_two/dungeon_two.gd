extends Node2D

var minWidth: int = 5
var minHeight: int = 5
var maxWidth: int = 20
var maxHeight: int = 20

var corridorMaxWidth: int = 5

var corridorMinLength: int = 10
var corridorMaxLength: int = 30

var roomConf = {'room': {"width": 0, "height": 0}, 'corridor': { 'width': 0, 'height': 0, 'position': Vector2i(0, 0)}}


var roomInfo = { "topLeft": Vector2i(0, 0), "bottomRight": Vector2i(0, 0), "bottomLeft": Vector2i(0, 0), "topRight": Vector2i(0, 0)}
var corInfo = { "topLeft": Vector2i(0, 0), "bottomRight": Vector2i(0, 0), "bottomLeft": Vector2i(0, 0), "topRight": Vector2i(0, 0), "direction": 0}



func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		#%TileMap.clear()
		generateRoom()
	elif Input.is_action_just_pressed("drop"):
		generateCorridor()
	elif Input.is_action_just_pressed("ui_cancel"):
		%TileMap.clear()
	

func generateRoom():
	# Generate a random width and height for the room
	var rng = RandomNumberGenerator.new()
	var width = rng.randi_range(minWidth, maxWidth)
	var height = rng.randi_range(minHeight, maxHeight)
	###

	# Set the position of the room
	#var corridorWidth = corInfo["bottomRight"].x - corInfo["bottomLeft"].x
	#var corridorHeight = corInfo["bottomLeft"].y - corInfo["topLeft"].y
	

	# Set the position of the room
	var startX = 0
	var startY = 0

	if corInfo["direction"] == 1:
		startX = corInfo["bottomRight"].x
		startY = corInfo["bottomLeft"].y
	elif corInfo["direction"] == 2:
		startX = corInfo["bottomLeft"].x
		startY = corInfo["topLeft"].y

	for x in range(width):
		for y in range(height):
			$TileMap.set_cell(0, Vector2i(startX + x, startY + y), 1, Vector2(2, 2))
			$TileMap.set_cells_terrain_connect(0, [Vector2i(startX + x, startY + y)], 0, 0, false)

	roomConf["room"] = {"width": startX+width, "height": startY+height}

	var topleft = Vector2i(startX, startY)
	var bottomright = Vector2i(startX+width, startY+height)
	var bottomLeft = Vector2i(startX, startY+height)
	var topRight = Vector2i(startX+width, startY)

	roomInfo = {"topLeft": topleft, "bottomRight": bottomright, "bottomLeft": bottomLeft, "topRight": topRight}
	print(roomInfo)


func generateCorridor():
	var rng = RandomNumberGenerator.new()
	var direction = rng.randi_range(1, 2)

	if direction == 1:
		print("Vertical")
	elif direction == 2:
		print("Horizontal")

	var width = 5
	var height = 20
	var posX = 0
	var posY = 0

	

	if direction == 1:
		posX = rng.randi_range(roomInfo["bottomLeft"].x, roomInfo["bottomRight"].x)  # Adjusted range to avoid spawning outside the room
		posY = roomInfo["bottomLeft"].y  # Adjusted range to avoid spawning outside the room
	elif direction == 2:
		posX = roomInfo["bottomLeft"].x  # Adjusted range to avoid spawning outside the room
		posY = rng.randi_range(roomInfo["bottomLeft"].y, roomInfo["topLeft"].y)  # Adjusted range to avoid spawning outside the room

	var nameX
	var nameY

	for x in range(width):
		for y in range(height):
			if direction == 1:
				nameX = posX + x
				nameY = posY + y
			elif direction == 2:
				nameX = posX + y
				nameY = posY + x
			$TileMap.set_cell(0, Vector2i(nameX, nameY), 1, Vector2(2, 2))
			$TileMap.set_cells_terrain_connect(0, [Vector2i(nameX, nameY)], 0, 0, false)

	var bottomLeft = Vector2i(posX, posY+height)
	var topRight = Vector2i(posX+width, posY)
	var bottomRight = Vector2i(posX+width, posY+height)
	var topLeft = Vector2i(posX, posY)

	corInfo = {"topLeft": topLeft, "bottomRight": bottomRight, "bottomLeft": bottomLeft, "topRight": topRight, "direction": direction}

	