extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	# check if the scene manager has a player, if so add it as a child
	if ScenesManager.player:
		add_child(ScenesManager.player)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
