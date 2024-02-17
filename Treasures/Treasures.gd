extends Node

@onready var jFile = "./Treasures/Treasures.json"
@onready var player = $Player

var COMMON_RARITY = 60
var UNCOMMON_RARITY = 25
var RARE_RARITY = 10
var EPIC_RARITY = 5

var closeToItem = false
var itemSlot

var item_name: String
var item_desc: String
var item_sprite: String

var item_weight: int
var item_value: int

var item_stamina_capacity: int
var item_stamina_gain: int

var item_health_capacity: int
var item_health_gain: int

var item_weight_capacity: int
var item_firerate: int


func _ready():
	# Load treasure
	var treasure = initTreasure()

	$pickUpObj.visible = false
	$pickUpObj/pickupPanel/AnimationPlayer.play('floating')
	$pickUpObj/pickupPanel/RichTextLabel.text = '[center]'+item_name


	$Sprite2D.scale.x = 0.05
	$Sprite2D.scale.y = 0.05
	$Sprite2D.texture = load("res://Treasures/Assets/" + item_sprite)

	# Set the item name


# Called when the node enters the scene tree for the first time.
func _process(delta):
	if player.position.distance_to(self.position) < 100:
		print("Close to gun")
		$pickUpObj.visible = true
		closeToItem = true
		if Input.is_key_pressed(KEY_E):
			print("E")
			pass # add to player
	else:
		print("Not close to gun")
		$pickUpObj.visible = false
		closeToItem = false # make thing disapear
	return # End function right here

func initTreasure():
	var file = FileAccess.open(jFile, FileAccess.READ)
	var content = file.get_as_text()
	var json = JSON.new()
	var final = json.parse_string(content)

	# Get the rarity of the item
	var rarity = determineRarity()

	# Access the item based on rarity
	var items = final["Items"]["Rarity"][rarity]
	var itemKeys = items.keys()
	var randomKey = itemKeys[randi() % itemKeys.size()]
	var itemDetails = items[randomKey]

	print("Item Details: ", itemDetails)

	item_name = itemDetails["Name"]
	item_desc = itemDetails["Description"]
	item_sprite = itemDetails["Sprite"]

	item_weight = itemDetails["Weight"]
	item_value = itemDetails["Value"]

	item_stamina_capacity = itemDetails["StaminaCapacity"]
	item_stamina_gain = itemDetails["StaminaGain"]

	item_health_capacity = itemDetails["HealthCapacity"]
	item_health_gain = itemDetails["HealthGain"]

	item_weight_capacity = itemDetails["WeightCapacity"]
	item_firerate = itemDetails["FireRate"]

	

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

	
