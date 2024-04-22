extends BaseScene


# Called when the node enters the scene tree for the first time.
func _ready():
	add_treasures_to_grass(20)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

# Place a specific amount of treasures random locations
func add_treasures_to_grass(maxTreasures):
	var randX
	var randY
	var randCell
	var instance
	var treasuresAdded = 0
	var tilemap = get_node("ForestMap").get_node("Forest")  
	print("ready to spawn")
	while treasuresAdded < maxTreasures:
		# For every treasure, generate a random location 
		randX = randf_range(0, 1280)
		randY = randf_range(0, 710) 
		randCell = Vector2(randX, randY)    
		# only spawn if it's on a treasure spawnable tile
		if tilemap.get_cell_source_id(0, tilemap.local_to_map(randCell)) != -1: 
			instance = Treasure.instantiate()
			instance.position = randCell
			add_child(instance) 
			treasuresAdded += 1
			print(treasuresAdded)