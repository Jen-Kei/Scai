extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	Globals.currentScene = "DungeonZero"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	change_scene()


# FUNCTIONS FOR SCENE TRANSITIONS
func _on_dungeon_zero_main_exit_body_entered(body:Node2D):
	if body.has_method("player"):
		Globals.transitionScene = true


func _on_dungeon_zero_main_exit_body_exited(body:Node2D):
	if body.has_method("player"):
		Globals.transitionScene = false

func change_scene():
	if Globals.transitionScene == true:
		print(Globals.currentScene)
		if Globals.currentScene == "DungeonZero":
			print("in again")
			get_tree().change_scene_to_file("res://Forest/Forest.tscn")
			Globals.gameFirstLoadIn = false # set first time loading in to false
			Globals.finish_change_scenes()