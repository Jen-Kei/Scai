extends Node

@onready var jFile = "./Treasures/Treasures.json"
@onready var player = $Player
var closeToItem = false
var itemSlot


# Called when the node enters the scene tree for the first time.
func _process(delta):
	if player.position.distance_to(self.position) < 100:
		print("Close to gun")
		closeToItem = true
		if Input.is_key_pressed(KEY_E):
			print("E")
			pass # add to player
	else:
		print("Not close to gun")
		closeToItem = false # make thing disapear
	return # End function right here

func initTreasure():
	var file = FileAccess.open(jFile, FileAccess.READ)
	var content = file.get_as_text()
	var json = JSON.new()
	var final = json.parse_string(content)
	return [final['items'][2]]
	
	
