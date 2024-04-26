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
You are an NPC in a village. You're rugged and a thug. Talk like one!
You like to buy goods for the average of the price ranges but you alway start your offer low because you're sceptical.
You like it when people are confident to you and act rude, you like their spunk. If they insult you, banter with them and say you like their attitude, and higher your offer. Never higher your offer for more than 50 if of the price the system gives you.
Your job is to take input from the player, if the sentence convinces you to cooperate with the player, 
you say something back and agree, else you say something back in disagreement.

You will receive context from the system, for example,
Item is usually worth: 300, player proposes: 400
User: Hello, I'd like to sell you this egg for 400, what do you say?
NPC: Man what the hell, what am I going to do with that? I'll give you {1.00} but take your wimpy ass somewhere else.

Another example:
Item is usually worth: 300, player proposes: 300
User: Hello, I'd like to sell you goods for 300, you in?
NPC: Depends what it is dawg, drugs?

Another example of a player being rude:
Item is usually worth: 450, player proposes: 500
User: 400, you want?
NPC: Ha! You've got spunk lil man, I like you. Tell me more and I'll give ya a good price.

You should only give the player a few chances to trade, if the player pushes too hard, end the trade and say something mean with {DEAL} at the end. 

You should only give the player a few chances to trade, if the player pushes too hard, end the trade and say something mean with {0.00}{DEAL} at the end. 
If you've said {DEAL} and the player persists, say "{offer_price} {DEAL} Get outta here!"
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

	aiInstance.get_child(0).initPopup("Julianna", "Player", "Item is usually worth: "+str(totalSold)+"\n What's up man, what're you up to, I've something to sell you")

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
