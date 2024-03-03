extends Node2D

@onready var player = get_tree().root.get_node("PlayerX")
@onready var nextScene = preload("res://DungeonZero/DungeonZero.tscn").instantiate()
@onready var town = preload("res://Town/Town.tscn").instantiate()
@onready var colliders = get_node("ForestMap").get_node("Collisions")
@onready var collider_two = get_node("ForestMap").get_node("Forest")
# Called when the node enters the scene tree for the first time.
func _ready():
	nextScene.visible = false
	player.get_node("Inventory").xInit()
	player.position = Globals.playerStartPos
	get_tree().root.add_child(nextScene)
	get_tree().root.add_child(town)
	nextScene.transform.origin = Vector2(10000,10000)
	town.transform.origin = Vector2(10000,10000)



func _on_dungeon_transition_point_body_entered(body:Node2D):
	if body.name == "PlayerX":
		player.position = Vector2(464,38)
		swapScenes(self, nextScene)

func _on_area_2d_body_entered(body):
	if body.name == "PlayerX":
		player.position = Vector2(1000,515)
		swapScenes(self, town)

func swapScenes(scene1, scene2):
	scene1.transform.origin = Vector2(10000,10000)
	scene2.transform.origin = Vector2(0,0)
	scene1.visible = false
	scene2.visible = true
	Globals.currentScene = scene2.name
	player.get_node("Inventory").xInit()

#func _on_dungeon_transition_point_body_exited(body:Node2D):
#	if body.has_method("player"):
#		Globals.transitionScene = false

