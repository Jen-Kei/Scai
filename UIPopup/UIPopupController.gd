extends Control

var aiName: String
var userName: String
var price: String = ''
var typingSpeed: float = 0.05

var currentPrice: String = ''
var deal: bool = false
var result = []
var triggers = ['DEAL', 'GUARDS']
var emotions = ['HAPPY', 'SAD', 'ANGRY', 'NEUTRAL']

var canType = false

signal dealEnded

func _ready():
	%AIRequest.chat_response_recieved.connect(_on_chat_response_recieved)

func change_proompt(proompt):
	%AIRequest.sysProompt = proompt
	%AIRequest.current_conversation = [{"role": "system", "content": proompt}]

func initPopup(ai_name, user_name, preMessage): # Initialize the popup
	aiName = ai_name
	userName = user_name
	%AI_Name.text = str(aiName)
	%User_Name.text = str(userName)
	%AIRequest.chatToPT(preMessage+"\nHello!")

func _on_submit_btn_button_down(): # Press enter
	print(canType)
	if !canType:
		return
	var new_text = %User_TextBox.text
	new_text = new_text.strip_edges(true,true)
	%AI_TextBox.text += '\n'+userName+': ' + new_text + '\n'
	%User_TextBox.text = ''
	%AIRequest.chatToPT(new_text)
	canType = false

func _on_chat_response_recieved(response:String): # Chat response recieved
	%AI_TextBox.text += aiName+': '
	get_text_between_braces(response)
	var regex = RegEx.new()
	regex.compile("\\{([a-z, A-Z}]*)\\}")
	var matches = regex.search_all(response)
	for match in matches:
		response = response.replace(match.get_string(0), '')

	slowPrint(response)

func slowPrint(text): # Slowly print the text like chatgpt
	var i = 0
	while i < text.length():
		%AI_TextBox.text += text[i]
		i += 1
		await get_tree().create_timer(typingSpeed).timeout
	
	canType = true
	

func get_text_between_braces(input_string: String):
		var trigger
		var emotion

		var regex = RegEx.new()
		regex.compile("\\{([^}]*)\\}")
		var matches = regex.search_all(input_string)
		result = []
		for match in matches:
			result.append(match.get_string(1))

		var numRegex = RegEx.new()
		numRegex.compile("\\{(\\d+(\\.\\d+)?)\\}")
		var numMatches = numRegex.search_all(input_string)
		for match in numMatches:
			currentPrice = match.get_string(1)
		
		print(result)
		# Check if the result is empty
		if result.size() == 0:
			print("No matches found, function returning...")
			return # END FUNCTION

		for i in result:
			if i == 'DEAL':
				trigger = 'DEAL'
			elif i == 'GUARDS':
				trigger = 'GUARDS'
			elif i == 'HAPPY':
				emotion = 'HAPPY'
				%AI_Pic.texture = load('res://UIPopup/Assets/Happy.jpg')
			elif i == 'ANGRY':
				emotion = 'ANGRY'
				%AI_Pic.texture = load('res://UIPopup/Assets/Angry.jpg')
			elif i == 'NEUTRAL':
				emotion = 'NEUTRAL'
				%AI_Pic.texture = load('res://UIPopup/Assets/Neutral.jpg')
			elif i == 'SAD':
				emotion = 'SAD'
				%AI_Pic.texture = load('res://UIPopup/Assets/Neutral.jpg')

		print(
			"The AI is feeling: ", emotion,
			 "\nThe AI has triggered: ", trigger, # emit signal for DEAL
			 "\nThe current price is: ", currentPrice
			 )


		# Deal ended
		if trigger == "DEAL":
			dealEnded.emit()
			Globals.moneyAmount += int(currentPrice)




func _on_back_btn_button_down():
	dealEnded.emit()