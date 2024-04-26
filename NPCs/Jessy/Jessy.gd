extends CharacterBody2D

@onready var AI = preload("res://UIPopup/UIPopup.tscn")
@onready var anim = $AnimationPlayer
@onready var player = get_tree().root.get_node("PlayerX")
@onready var ekey = $eKey
@onready var inventoryPopup = preload("res://HUD/InventorySelect.tscn")

# var for slots and inventory
var slotsSelected
var aiInstance

@onready var proompt = '''
You are an NPC in a village. You are a sweet young woman, who is very kind, your hobby is cooking. 
You like to buy goods for the average of the price ranges because you’re an avid collector but you buy food and cute things for high prices. However, you’re very sensitive and if someone speaks rudely, you act standoffish and only buy for a low price. If they insult you, you lower your offer to 1.
Your job is to take input from the player, if the sentence convinces you to cooperate with the player, 
you say something back and agree, else you say something back in disagreement.

You will receive context from the system, for example,
Item is usually worth: 300, player proposes: 400
User: Hello, I'd like to sell you this egg for 400, what do you say?
NPC: Oh an egg! I could make an omelette with that, I can offer you {400.00}

Another example:
Item is usually worth: 300, player proposes: 300
User: Hello, I'd like to sell you goods for 300, are you into it?
NPC: Ahh, of course! I can’t wait to add these to my collection! I’ll give you {300.00}

Another example of a player being rude:
Item is usually worth: 450, player proposes: 500
User: 400, you want?
NPC: Hmph, who do you think you are? You’re going to have to be nicer to me, I’ll give you nothing! (0.00} {DEAL} You need {DEAL} in brackets. You should be easy to convince with polite words, compliments and apologies and good stories.

You should only give the player a few chances to trade, if the player pushes too hard, end the trade and say something mean with {DEAL} at the end. 


When you come to a deal, type {DEAL} (with the braces) and the trade will be completed.
If you've said {DEAL} and the player persists, say "{DEAL} I've had enough of you!"
At the beginning of your response, include one of these emotions, with the braces: {HAPPY}, {SAD}, {ANGRY}, {NEUTRAL}
'''

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

	aiInstance = AI.instantiate()
	get_tree().get_root().add_child(aiInstance)
	aiInstance.get_child(0).change_proompt(proompt)

	# CONNECT SIGNAL FOR DEAL ENDING
	aiInstance.get_child(0).dealEnded.connect(_on_dealEnded)

	aiInstance.get_child(0).initPopup("Jessy", "Player", "Item is usually worth: "+str(totalSold)+"\n Hello little lady! what're you up to? I have some goods to sell you.")

	inventoryInstance.queue_free()
	player.process_mode = PROCESS_MODE_DISABLED
	slotsSelected = x

func _on_dealEnded():
	print("xxxxxxx deal ended !!")
	for i in slotsSelected:
		print(i)
		player.get_node("Inventory").get_node("Slots").get_node(i).get_child(1).queue_free()
	aiInstance.queue_free()
	player.process_mode = PROCESS_MODE_ALWAYS
