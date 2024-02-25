extends Node2D

var Treasure = preload("res://Treasures/Treasures.tscn")
@onready var Map = get_tree().root.get_child(0).get_node("ForestMap").get_node("Forest")

# INITIALISE VARIABLES
var pos = Vector2(0, 0)
var maxTreasures = 20

# Called when the node enters the scene tree for the first time.
func _ready():
	add_treasures_to_grass()
	randomize()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


# Place a specific amount of treasures on grass tiles in random locations
func add_treasures_to_grass():
	var randX
	var randY
	var randCell
	var instance
	var treasuresAdded = 0


	# For every treasure, generate a random location 
	while treasuresAdded <= maxTreasures:
		randX = randf_range(0, 1280)
		randY = randf_range(0, 710)

		randCell = Vector2(randX, randY)

		# only spawn if it's on a grass tile
		if Map.get_cell_source_id(2, randCell) != -1:
			print("is cell", Map.get_cell_source_id(2, randCell, false))
			instance = Treasure.instantiate()
			instance.position = randCell
			add_child(instance)
			treasuresAdded += 1
			print(treasuresAdded)
			print(randCell)
		

			
	

