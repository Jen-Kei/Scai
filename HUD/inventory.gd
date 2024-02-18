extends Control

@onready var Slots = [$Slots/Slot1, $Slots/Slot2, $Slots/Slot3, $Slots/Slot4, $Slots/Slot5]
@onready var player = get_tree().root.get_child(0).get_node("Player")
var currentlySelected: int
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	inventoryControl()


func inventoryControl():
	if Input.is_action_just_pressed('one'):
		print('Pressed 1')
		for i in Slots:
			i.modulate = Color(1, 1, 1, 1)
		Slots[0].modulate = Color(255, 255, 0, 1)
		currentlySelected = 0
	elif Input.is_action_just_pressed('two'):
		print('Pressed 2')
		for i in Slots:
			i.modulate = Color(1, 1, 1, 1)
		Slots[1].modulate = Color(255, 255, 0, 1)
		currentlySelected = 1
	elif Input.is_action_just_pressed('three'):
		print('Pressed 3')
		for i in Slots:
			i.modulate = Color(1, 1, 1, 1)
		Slots[2].modulate = Color(255, 255, 0, 1)
		currentlySelected = 2
	elif Input.is_action_just_pressed('four'):
		print('Pressed 4')
		for i in Slots:
			i.modulate = Color(1, 1, 1, 1)
		Slots[3].modulate = Color(255, 255, 0, 1)
		currentlySelected = 3
	elif Input.is_action_just_pressed('five'):
		print('Pressed 5')
		for i in Slots:
			i.modulate = Color(1, 1, 1, 1)
		Slots[4].modulate = Color(255, 255, 0, 1)
		currentlySelected = 4
	elif Input.is_action_just_pressed('drop'):
		if Slots[currentlySelected].get_children().size() == 1:
			print("Nothing to drop")
			return
		
		var droppedItem = Slots[currentlySelected].get_children()[1]
		var item = droppedItem.duplicate()
		#print(player.global_position)
		item.global_position = player.global_position
		get_tree().root.get_child(0).get_node("Treasures").add_child(item)
		var objPos = get_tree().root.get_child(0).get_node("Treasures").get_children().size()
		var obj = get_tree().root.get_child(0).get_node("Treasures").get_child(objPos-1)
		obj.initTreasure(droppedItem._itemDetails)
		obj.pickedUp = false

		Slots[currentlySelected].get_children()[1].queue_free()
	else:
		pass
