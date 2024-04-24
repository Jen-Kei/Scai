extends CanvasLayer

@onready var Slots = [$Slots/Slot1, $Slots/Slot2, $Slots/Slot3, $Slots/Slot4, $Slots/Slot5]
@onready var player = get_tree().root.get_node("PlayerX")
var currentlySelected: int
var treasures
@onready var statBank = %StatBank

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func xInit():
	print(Globals.currentScene)
	treasures = get_tree().root.get_node(str(Globals.currentScene)).get_node("Treasures")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	inventoryControl()

func inventoryControl():
	if Input.is_action_just_pressed('one'):
		print('Pressed 1')
		selectSlot(0)
	elif Input.is_action_just_pressed('two'):
		print('Pressed 2')
		selectSlot(1)
	elif Input.is_action_just_pressed('three'):
		print('Pressed 3')
		selectSlot(2)
	elif Input.is_action_just_pressed('four'):
		print('Pressed 4')
		selectSlot(3)
	elif Input.is_action_just_pressed('five'):
		print('Pressed 5')
		selectSlot(4)
	elif Input.is_action_just_pressed('drop'):
		if Slots[currentlySelected].get_children().size() == 1:
			print("Nothing to drop")
			return

		dropItem()
	else:
		pass

func selectSlot(slot: int):
	for i in Slots:
		i.modulate = Color(1, 1, 1, 1)
	Slots[slot].modulate = Color(255, 255, 0, 1)
	currentlySelected = slot

func dropItem():
	var droppedItem = Slots[currentlySelected].get_children()[1] # Get the item that is being dropped
	statBank.appendStats(droppedItem._itemDetails, false) # Append the stats of the item to the stat bank
	var item = droppedItem.duplicate() # Duplicate the item

	item.global_position = player.global_position # Set the position of the item to the player's position
	treasures.add_child(item) # Add the item to the treasures node

	var objPos = treasures.get_children().size() # Get the position of the item in the treasures node
	var obj = treasures.get_child(objPos-1) # Get the item from the treasures node

	obj.initTreasure(droppedItem._itemDetails) # Initialize the item with the details of the dropped item
	obj.pickedUp = false # Set the pickedUp variable to false

	Slots[currentlySelected].get_children()[1].queue_free() # Remove the item from the inventory
