extends Control

var forestScene = "res://Forest/Forest.tscn"
var player = preload("res://Player/Player.tscn").instantiate()

func _on_play_button_button_down():
	print("Pressed Play")
	player.name = "PlayerX"
	get_tree().root.add_child(player)
	get_tree().change_scene_to_file(forestScene)
