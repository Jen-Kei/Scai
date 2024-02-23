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

func _ready():
	%AIRequest.chat_response_recieved.connect(_on_chat_response_recieved)
	initPopup('AI', 'User')

func initPopup(ai_name, user_name): # Initialize the popup
	aiName = ai_name
	userName = user_name
	%AI_Name.text = '[center]'+str(aiName)
	%User_Name.text = '[center]'+str(userName)
	%AIRequest.chatToPT("Hello Sir")


func _on_user_text_box_text_submitted(new_text:String): # Press enter
	%AI_TextBox.text += '\n'+userName+': ' + %User_TextBox.text + '\n'
	%User_TextBox.text = ''
	%AIRequest.chatToPT(new_text)

func _on_chat_response_recieved(response:String): # Chat response recieved
	%AI_TextBox.text += aiName+': '
	get_text_between_braces(response)
	slowPrint(response)

func slowPrint(text): # Slowly print the text like chatgpt
	var i = 0
	while i < text.length():
		%AI_TextBox.text += text[i]
		i += 1
		await get_tree().create_timer(typingSpeed).timeout
	
	if result.size() == 0: return

	if result[0] == 'DEAL':
		print("The deal is done at price: ", currentPrice)
	
	if result[0] == 'GUARDS':
		print("The guards are on their way")
	
	
func get_text_between_braces(input_string: String):
		var regex = RegEx.new()
		regex.compile("\\{([^}]*)\\}")
	
		var matches = regex.search_all(input_string)
		result = []
	
		for match in matches:
			result.append(match.get_string(1))
		
		# Check if the result is empty
		if result.size() == 0:
			print("No matches found")
			return # END FUNCTION

		# Check if the result is a trigger
		for i in triggers:
			if result[0] == i:
				print("Trigger found: ", i)
				return # END FUNCTION

		# Check if the result is an emotion
		for i in emotions:
			if result[0] == i:
				print("Emotion found: ", i)
				if i == 'HAPPY':
					print("The AI is happy")
					%AI_Pic.texture = load('res://UIPopup/Assets/Happy.jpg')
				if i == 'SAD':
					print("The AI is sad")
				elif i == 'ANGRY':
					%AI_Pic.texture = load('res://UIPopup/Assets/Angry.jpg')
				elif i == 'NEUTRAL':
					print("The AI is neutral")
					%AI_Pic.texture = load('res://UIPopup/Assets/Neutral.jpg')
				
				return # END FUNCTION

		currentPrice = result[0]
		print("The current price is: ", currentPrice)