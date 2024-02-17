extends Control

var aiName: String
var userName: String

func _ready():
	%AIRequest.chat_response_recieved.connect(_on_chat_response_recieved)
	initPopup('AI', 'User')

func initPopup(ai_name, user_name):
	aiName = ai_name
	userName = user_name
	%AI_Name.text = '[center]'+str(aiName)
	%User_Name.text = '[center]'+str(userName)
	%AIRequest.chatToPT("Hello Sir")


func _on_user_text_box_text_submitted(new_text:String):
	%AI_TextBox.text += '\n'+userName+': ' + %User_TextBox.text + '\n'
	%User_TextBox.text = ''
	%AIRequest.chatToPT(new_text)

func _on_chat_response_recieved(response:String):
	%AI_TextBox.text += aiName+': '
	slowPrint(response)

func slowPrint(text):
	var i = 0
	while i < text.length():
		%AI_TextBox.text += text[i]
		i += 1
		await get_tree().create_timer(0.05).timeout
	