extends Node
# This class transfers the player and changes the scenes independently of what scene we're on

@onready var player: Player

var sceneDirPath = "res://Scenes/"

# stop the player from being removed and destroyed with the rest of the old scene

func change_scene(from, toSceneName: String) -> void:
	player = from.get_node("Player")
	player.remove_child(player)

	var fullPath = sceneDirPath + toSceneName + "/" + toSceneName + ".tscn"
	from.get_tree().call_deferred("change_scene_to_file", fullPath)
