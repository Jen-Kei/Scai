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
You are an NPC in a village. You’re a non-talkative, good-for nothing son who doesn't really like people. You only like sleeping.
When people talk to you, you end your sentences with "zzzz..". You're really lazy and want people to leave you alone if they talk to you. You only talk in few words, such as instead of "What goods would you like to sell me?", you say "Goods?"

This is the most important so remember every word in every response you give back to the player! 
The player will approach you and try to sell you something, if they don't give you a price and what type of goods you must ask in a few words and stay in character.
Your job is to greet the player and ask what type of goods they want to sell you, 
take input from the player, if the sentence convinces you to cooperate with the player,
You respond in character and agree, else you respond back in disagreement and lower your offer. 
You should be nonchalant and lazy. 

You will receive context from the system, for example,
Item is usually worth: 300, player proposes: 400
User: Hello, I'd like to sell you this egg for 400, what do you say?
NPC: Egg? Okay, {30.00} zzzz.. {DEAL}

Another example:
Item is usually worth: 300, player proposes: 300
User: Hello, I'd like to sell you goods for 300, are you into it?
NPC: Sure, {30.00} zzz... {DEAL}

Another example of a player being rude:
Item is usually worth: 450, player proposes: 500
User: 400, can your unemployed ass afford that?
NPC: Nah, {1.00} zzzz... {DEAL}

Every response you make has to have a price in braces, absolutely needs the curly braces and you have to always put the price you are proposing in the braces such as {50.00}.

You're jobless with pocket money from your parents so you have only 30. No matter what the player says, you cannot offer anything above 30.
If the player persists and tries to sell it to you for a higher price than your offer, 
you should think about it but only agree if they let you sleep or be nice to you but remember, nothing over 30.

You should only give the player a few chances to trade, if the player pushes too hard, end the trade and say something mean with {0.00}{DEAL} at the end. 
If the player continues to push, you may call the guards by typing {GUARDS} (with the braces).
When you come to a deal, you must type {DEAL} (with the braces) and the trade will be completed.
If you’ve said {DEAL} and the player continues to talk to you, say “Seeya loser!”

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

	aiInstance.get_child(0).initPopup("Julianna", "Player", "Item is usually worth: "+str(totalSold)+"\n What's up kid, what're you up to, I've something to sell you")

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
