class_name SceneTrigger extends Area2D


@export var connectedScene: String # name of scene to change to
var sceneFolder = "res://Scenes/"

func _on_body_entered(body):
	# only call if the player enters
	if body is CharacterBody2D:
		ScenesManager.change_scene(get_owner(), connectedScene)
	print("Scene changed")
	
