extends CanvasLayer

@onready var ActionList = $Control/PanelContainer/VBoxContainer/ScrollContainer/ActionList
@onready var itemBTN = preload("res://HUD/ItemButton.tscn")
@onready var player = get_tree().root.get_node("PlayerX")
@onready var sellBTN = $Control/PanelContainer/sellBTN

signal sellItems
# Called when the node enters the scene tree for the first time.

'''
	# Access the item based on rarity
	var items = final["Items"]["Rarity"]["Common"]
	var itemKeys = items.keys() # Get the keys of the item list
	var randomKey = itemKeys[randi() % itemKeys.size()] # Get a random key from the item list
	print(items[randomKey])
	# Access the item based on the random key
	Xname = items[randomKey]["Name"]
	Xdescription = items[randomKey]["Description"]
	Xsprite = items[randomKey]["Sprite"]
	_create_action_list()
'''

func _ready():
	print(get_parent())
	print(player)
	sellBTN.visible = false
	_create_action_list()

	

func _process(delta):
	if Input.is_action_just_pressed("inventory"):
		player.inventoryOpen = false
		self.queue_free()

func _create_action_list():
	for item in ActionList.get_children():
		item.queue_free()

	# iterate through the slots and see if it only has 1 child (it's empty, only has the texture rect)
	for i in player.get_node("Inventory").get_node("Slots").get_children():
		if i.get_children().size() == 1:
			print("Empty")
			continue
		var item = i.get_child(1) # instance of the treasure
		
		var itemBTN = itemBTN.instantiate()
		itemBTN.itemSlot = i.name
		itemBTN.get_node("Button").text = item.item_name
		itemBTN.get_node("pic").texture = load("res://Treasures/Assets/"+item.item_sprite)
		itemBTN.get_node("RdescLabel").text = '[center]'+item.item_desc
		itemBTN.itemValue = item.item_value
		if item.item_value < 50:
			itemBTN.get_node("RtextLabel").text = "0 - 50"
		elif item.item_value < 100:
			itemBTN.get_node("RtextLabel").text = "50 - 100"
		elif item.item_value < 150:
			itemBTN.get_node("RtextLabel").text = "100 - 150"
		elif item.item_value < 200:
			itemBTN.get_node("RtextLabel").text = "150 - 200"
		elif item.item_value < 250:
			itemBTN.get_node("RtextLabel").text = "200 - 250"
		elif item.item_value < 300:
			itemBTN.get_node("RtextLabel").text = "250 - 300"
		elif item.item_value < 350:
			itemBTN.get_node("RtextLabel").text = "??? - ???"

		ActionList.add_child(itemBTN)

func _on_sell_btn_button_down():
	getSelectedValue()

func _on_sell_btn_1_button_down():
	sellItems.emit(getSelectedValue())



func getSelectedValue():
	var total = 0
	var items = {}
	for i in ActionList.get_children():
		if i.pressedDown:
			total += i.itemValue
			items[i.itemSlot] = i.itemValue

	return items


func _on_dealEnded():
	pass