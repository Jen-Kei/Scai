extends Node

@onready var jFile = "./Treasures/Treasures.json"
@onready var player = get_tree().root.get_child(0).get_node("Player")

var COMMON_RARITY = 60
var UNCOMMON_RARITY = 25
var RARE_RARITY = 10
var EPIC_RARITY = 5

var closeToItem = false
var itemSlot

var item_name: String
var item_desc: String
var item_sprite: String

var item_weight: float
var item_value: float

var item_speed: float

var item_stamina_capacity: float
var item_stamina_gain: float

var item_health_capacity: float
var item_health_gain: float

var item_weight_capacity: float
var item_firerate: float
var pickedUp: bool = false
var perimeter: int = 50

var _itemDetails


func _ready():
	# Load treasure
	_itemDetails = initTreasure({})


# Called when the node enters the scene tree for the first time.
func _process(delta):
	if pickedUp: return # If the item has been picked up, end the function

	if player.position.distance_to(self.position) < perimeter: # If the player is close to the gun
		$pickUpObj.visible = true # Show the pickup object
		closeToItem = true
		if Input.is_action_just_pressed("interact"):
			print("Pressed E")
			for i in (player.get_node("Inventory").get_node("Slots").get_children()): # Loop through the player's inventory
				if i.get_children().size() == 1: # If the inventory slot is empty
					print(i.name, " is empty") # Print the name of the empty slot
					var me: Node = duplicate() # Duplicate the item
					print("Adding to inventory: ",me.name, ' In ', i.name) # Print the name of the item and the slot it's being added to
					i.add_child(me) # Add the item to the inventory
					i.get_child(1).initTreasure(_itemDetails) # Initialize the item
					self.queue_free() # Remove the item from the scene
					pickedUp = true # Set pickedUp to true
					return # End the function
				print(i.name, " is full") # Print the name of the full slot
	else: # If the player is not close to the gun
		#print("Not close to gun")
		$pickUpObj.visible = false # Hide the pickup object
		closeToItem = false # make thing disapear
	return # End function right here

func initTreasure(args = {}):
	_itemDetails = args
	if args.size() == 0:
		var file = FileAccess.open(jFile, FileAccess.READ)
		var content = file.get_as_text()
		var json = JSON.new()
		var final = json.parse_string(content)

		# Get the rarity of the item
		var rarity = determineRarity()

		# Access the item based on rarity
		var items = final["Items"]["Rarity"][rarity]
		var itemKeys = items.keys() # Get the keys of the item list
		var randomKey = itemKeys[randi() % itemKeys.size()] # Get a random key from the item list
		_itemDetails = items[randomKey] # Get the details of the item

		print("Normal Item Spawned")#, _itemDetails)
	else:
		pickedUp = true
		print("OVERRIDDEN Item Spawned")#, _itemDetails)

	item_name = _itemDetails["Name"]
	item_desc = _itemDetails["Description"]
	item_sprite = _itemDetails["Sprite"]

	item_weight = _itemDetails["Weight"]
	item_value = _itemDetails["Value"]

	item_speed = _itemDetails["speed"]

	item_stamina_capacity = _itemDetails["StaminaCapacity"]
	item_stamina_gain = _itemDetails["StaminaGain"]

	item_health_capacity = _itemDetails["HealthCapacity"]
	item_health_gain = _itemDetails["HealthGain"]

	item_weight_capacity = _itemDetails["WeightCapacity"]
	item_firerate = _itemDetails["FireRate"]

	$pickUpObj.visible = false # Hide the pickup object
	$pickUpObj/pickupPanel/AnimationPlayer.play('floating') # Play the floating animation
	$pickUpObj/pickupPanel/RichTextLabel.text = '[center]'+item_name # Center the item name


	$Sprite2D.scale.x = 1 # Set the scale of the item
	$Sprite2D.scale.y = 1 # Set the scale of the item
	$Sprite2D.texture = load("res://Treasures/Assets/" + item_sprite) # Set the item sprite
	self.name = item_name

	return _itemDetails

	

func determineRarity():
	var rng = RandomNumberGenerator.new()
	var rarity = rng.randi_range(0, 100)

	if rarity < COMMON_RARITY:
		print("Common Item Spawned")
		return "Common"
	elif rarity < UNCOMMON_RARITY:
		print("Uncommon Item Spawned")
		return "Uncommon"
	elif rarity < RARE_RARITY:
		print("Rare Item Spawned")
		return "Rare"
	elif rarity < EPIC_RARITY:
		print("Epic Item Spawned")
		return "Epic"
	else:
		return "Common"

	
