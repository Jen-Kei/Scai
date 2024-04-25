extends Node2D

@onready var player = get_tree().root.get_node("PlayerX")
@onready var nextScene = preload("res://DungeonZero/DungeonZero.tscn").instantiate()
@onready var town = preload("res://Town/Town.tscn").instantiate()
@onready var colliders = get_node("ForestMap").get_node("Collisions")
@onready var collider_two = get_node("ForestMap").get_node("Forest")
var Treasure = preload("res://Treasures/Treasures.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	nextScene.visible = false
	player.get_node("Inventory").xInit()
	player.position = Globals.playerStartPos
	print(player.position, Globals.playerStartPos)
	get_tree().root.add_child(nextScene)
	get_tree().root.add_child(town)
	nextScene.transform.origin = Vector2(10000,10000)
	town.transform.origin = Vector2(10000,10000)

	# spawn treasures
	#add_treasures_to_grass(10)
	#nextScene.spawn_cats(Globals.maxCats)


func _on_dungeon_transition_point_body_entered(body:Node2D):
	if body.name == "PlayerX":
		player.position = Vector2(384,116)
		swapScenes(self, nextScene)

		
		nextScene.spawn_cats(Globals.maxCats)
		nextScene.spawn_treasures_dungeon(Globals.maxTreasures)
		
		

func _on_area_2d_body_entered(body):
	if body.name == "PlayerX":
		player.position = Vector2(1240,568)
		swapScenes(self, town)

func swapScenes(scene1, scene2):

	# get rid of the cats and treasures
	for i in get_node("Cats").get_children():
		i.queue_free()
		print("delete cat")
	for j in get_node("Treasures").get_children():
		j.queue_free()
		print("delete treasure") 
	

	scene1.transform.origin = Vector2(10000,10000)
	scene2.transform.origin = Vector2(0,0)
	scene1.visible = false
	scene2.visible = true
	Globals.currentScene = scene2.name
	player.get_node("Inventory").xInit()

#func _on_dungeon_transition_point_body_exited(body:Node2D):
#	if body.has_method("player"):
#		Globals.transitionScene = false


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
			get_node("Treasures").add_child(instance)

			treasuresAdded += 1
			print(treasuresAdded)
