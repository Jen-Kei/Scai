extends CharacterBody2D

@onready var AI = preload("res://UIPopup/UIPopup.tscn")
@onready var anim = $AnimationPlayer
@onready var player = get_tree().get_root().get_child(0).get_node("Player")
@onready var ekey = $eKey
@onready var inventoryPopup = preload("res://HUD/InventorySelect.tscn")
var inventoryInstance
var interacting = false

# Called when the node enters the scene tree for the first time.
func _ready():
	anim.speed_scale = 0.5
	anim.play("idle")
	ekey.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if player.position.distance_to(self.position) < 50:
		ekey.visible = true
		if Input.is_action_just_pressed("interact") and !interacting:
			interacting = true
			inventoryInstance = inventoryPopup.instantiate()
			get_parent().add_child(inventoryInstance)
			inventoryInstance.sellItems.connect(soldItems)
			#get_tree().get_root().add_child(AI.instantiate())
	else:
		ekey.visible = false

func soldItems(x):
	var totalSold = 0
	print("Selling: ", x)
	for i in x.values():
		totalSold += i
	print("Total Sold: ", totalSold)

	var aiInstance = AI.instantiate()
	get_tree().get_root().add_child(aiInstance)
	aiInstance.get_child(0).initPopup("Old Man", "Player", "Item is usually worth: "+str(totalSold)+"\n Hello sir!")
	inventoryInstance.queue_free()
	player.process_mode = PROCESS_MODE_DISABLED