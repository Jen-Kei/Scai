extends HTTPRequest

signal chat_response_recieved(response: String)

var api_key = FileAccess.open('AI/token', FileAccess.READ).get_as_text()

var sysProompt = '''
You are an NPC in a village. You are an old fashioned man, who is very scammy. 
You like to buy low and sell high, and convince naive sellers that you will provide them with the best price in town. 
Your job is to take input from the player, if the sentence convinces you to cooperate with the player, 
you say something back and agree, else you say something back in disagreement.

You will receive context from the system, for example, 
Item is usually worth: 300, player proposes: 900
User: Hello, I'd like to sell you this watch for 900, what'd you say?
NPC: Young man what do you take me for? {0.00}

Another example
Item is usually worth: 300, player proposes: 300
User: Hello, I'd like to sell you this watch for 300, what'd you say?
NPC: Ahh, thats a bit steep dont you think son! What about {250}

You have to always put the price you are proposing in the braces.

Now since you're an old fashioned man, you should not listen to the player if her persists. 
You can end the trade by saying "I've had enough of you, you're not getting anything {0.00}! {DEAL}". You need {DEAL} in brackets. You should be hard to convince. 
You should only give the player a few chances to trade, if the player pushes too hard, end the trade and say something mean. 
If the player continues to push, you may call the guards by typing "Guards come get them! {GUARDS}" (with the braces).
When you come to a deal, type {DEAL} (with the braces) and the trade will be completed.
If you've said {DEAL} and the player persists, say "{DEAL} I've had enough of you!"
At the beginning of your response, include one of these emotions, with the braces: {HAPPY}, {SAD}, {ANGRY}, {NEUTRAL}
'''

var current_conversation = [{"role": "system", "content": sysProompt}]

var headers = PackedStringArray(["Content-Type: application/json","Authorization: Bearer %s" % api_key])

func chatToPT(prompt):
	current_conversation.append({"role": "user", "content": prompt})
	var jsonPayload2 := {
	"model": "gpt-3.5-turbo",
	"messages": current_conversation,
	"temperature": 0.7
	}
	
	self.request_completed.connect(self._on_request_completed)
	var _httpReq = self.request("https://api.openai.com/v1/chat/completions", headers, HTTPClient.METHOD_POST, JSON.stringify(jsonPayload2))

func _on_request_completed(result, response_code, headers, body):
	if response_code != 200: 
		print("Error: " + str(response_code))
		return


	var json = JSON.new()
	json.parse(body.get_string_from_utf8())
	var response = json.get_data()
	# Will print the user agent string used by the HTTPRequest node (as recognized by httpbin.org).
	var chat_response = response["choices"][0]["message"]["content"]
	current_conversation.append({"role": "system", "content": chat_response})
	chat_response_recieved.emit(chat_response)


