extends Node2D

@onready var forest = get_tree().root.get_node("Forest")
@onready var player = get_tree().root.get_node("PlayerX")
@onready var CatBoom = preload("res://Enemies/Catboom/CatBoom.tscn")
var Treasure = preload("res://Treasures/Treasures.tscn")

# FUNCTIONS FOR SCENE TRANSITIONS
func _ready():
	player.get_node("Inventory").xInit()
	
func _on_dungeon_zero_main_exit_body_entered(body:Node2D):
	if body.name == "PlayerX":
		player.position = Vector2(1080,140)

	# on exit delete all the stuff so it's not visible in the other scenes
		for item in self.get_node("Cats").get_children():
			item.queue_free()
		for item in self.get_node("Treasures").get_children():
			item.queue_free()

		forest.swapScenes(self, forest)
		

func spawn_cats(maxCats):
	var randX
	var randY
	var randCell
	var instance
	var catsAdded = 0
	var tilemap = get_node("DungeonMapZero").get_child(0).get_node("TileMap")

	for i in range(0, maxCats):

		while catsAdded < maxCats:
			# For every cat, generate a random location 
			randX = randf_range(0, 1280)
			randY = randf_range(0, 710)

			randCell = Vector2(randX, randY)

			# only spawn if it's on a cat spawnable tile
			if tilemap.get_cell_source_id(2, tilemap.local_to_map(randCell)) != -1:
				print("is it a cell value: ", tilemap.get_cell_source_id(2, randCell, false))

				instance = CatBoom.instantiate()
				instance.position = randCell
				get_node("Cats").add_child(instance)

				catsAdded += 1
				print("added cats: ", catsAdded)

func spawn_treasures_dungeon(maxTreasures):
	var randX
	var randY
	var randCell
	var instance
	var treasuresAdded = 0
	var tilemap = get_node("DungeonMapZero").get_child(0).get_node("TileMap")

	for i in range(0, maxTreasures):

		while treasuresAdded < maxTreasures:
			# For every cat, generate a random location 
			randX = randf_range(0, 1280)
			randY = randf_range(0, 710)

			randCell = Vector2(randX, randY)

			# only spawn if it's on a cat spawnable tile
			if tilemap.get_cell_source_id(2, tilemap.local_to_map(randCell)) != -1:
				print("is it a cell value: ", tilemap.get_cell_source_id(2, randCell, false))

				instance = Treasure.instantiate()
				instance.position = randCell
				get_node("Treasures").add_child(instance)

				treasuresAdded += 1
				print("added treasures: ", treasuresAdded)
