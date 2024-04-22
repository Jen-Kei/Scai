class_name BaseScene extends Node

@onready var player: Player = $Player
@onready var entranceMarkers: Node2D = $EntranceMarkers
var Treasure = preload("res://Treasure/Treasures/Treasures.tscn")

func _ready():
    # Assuming scene_manager.player returns a reference to the player node
    var new_player = ScenesManager.player
    if new_player:
        if not $Player: # Check if player node doesn't exist
            player = new_player.instance() # Recreate player node
            add_child(player) # Add the new player node
        else:
            print("Player node already exists.")
    else:
        print("Error: No player object found in scene_manager.")
    position_player()


    # If forest map, spawn treasures
    if ScenesManager.fullPath == "res://Scenes/Forest/Forest.tscn":
        spawn_treasures(30)

func position_player() -> void:
    var lastScene = ScenesManager.lastSceneName
    if lastScene.is_empty():
        lastScene = "Any"
        print("was empty")  
    for entrance in entranceMarkers.get_children():
        if entrance is Marker2D and entrance.name == "Forest" or entrance.name == "Any":
            player.global_position = entrance.global_position


# Place a specific amount of treasures random locations on treasure spawnable tiles
func spawn_treasures(maxTreasures):
    var randX
    var randY
    var randCell
    var instance
    var treasuresAdded = 0
    var tilemap = get_node("ForestMap").get_node("Forest")  
    #print("ready to spawn")
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
            #print(treasuresAdded)