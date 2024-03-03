extends Node2D

@onready var player = preload("res://Player/PLayer.tscn").instantiate()

# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().root.call_deferred("add_child", player)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
