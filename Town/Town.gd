extends Node2D

@onready var forest = get_tree().root.get_node("Forest")
@onready var player = get_tree().root.get_node("PlayerX")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_body_entered(body:Node2D):
	forest.swapScenes(self, forest)
	player.transform.origin = Vector2(100,548)
