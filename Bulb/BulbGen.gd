extends Node2D

@onready var map = get_parent().get_child(1).get_child(0)
@onready var bulb = preload("res://Bulb/Bulb.tscn")


func _ready():
	var torchPos = map.get_used_cells(6)
	for torch in torchPos:
		var newBulb = bulb.instantiate()
		newBulb.position = map.map_to_local(torch)
		add_child(newBulb)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
