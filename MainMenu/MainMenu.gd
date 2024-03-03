extends Control

var forestScene = "res://Forest/Forest.tscn"
var player = preload("res://Player/Player.tscn").instantiate()
var keybinds = preload("res://escUI/changeBTNs.tscn")

func _on_play_button_button_down():
	print("Pressed Play")
	player.name = "PlayerX"
	get_tree().root.add_child(player)
	get_tree().change_scene_to_file(forestScene)

func _on_quit_button_button_down():
	get_tree().quit()

func _on_keybinds_button_button_down():
	add_child(keybinds.instantiate())