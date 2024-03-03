extends Node2D

@onready var forest = get_tree().root.get_node("Forest")
@onready var player = get_tree().root.get_node("PlayerX")
# FUNCTIONS FOR SCENE TRANSITIONS
func _ready():
	player.get_node("Inventory").xInit()
	
func _on_dungeon_zero_main_exit_body_entered(body:Node2D):
	if body.name == "PlayerX":
		player.position = Vector2(1080,140)
		forest.swapScenes(self, forest)