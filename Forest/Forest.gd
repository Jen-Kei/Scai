extends Node2D

@onready var player = get_tree().root.get_node("PlayerX")

# Called when the node enters the scene tree for the first time.
func _ready():
	Globals.currentScene = "Forest"
	if Globals.gameFirstLoadIn == true:
		player.position = Globals.playerStartPos
	else:
		player.position = Globals.playerExitDungeontPos


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	change_scene()


func _on_dungeon_transition_point_body_entered(body:Node2D):
	if body.has_method("player"):
		Globals.transitionScene = true


func _on_dungeon_transition_point_body_exited(body:Node2D):
	if body.has_method("player"):
		Globals.transitionScene = false

func change_scene():
	if Globals.transitionScene == true:
		if Globals.currentScene == "Forest":
			get_tree().change_scene_to_file("res://DungeonZero/DungeonZero.tscn")
			Globals.finish_change_scenes()
