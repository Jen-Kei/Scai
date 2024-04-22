class_name BaseScene extends Node

@onready var player: Player = $Player
@onready var entranceMarkers: Node2D = $EntranceMarkers

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

func position_player() -> void:
    for entrance in entranceMarkers.get_children():
        if entrance is Marker2D and entrance.name == "FromTownToForest":
            player.global_position = entrance.global_position
        if entrance is Marker2D and entrance.name == "FromForestToTown":
            player.global_position = entrance.global_position
