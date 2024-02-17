extends HTTPRequest

var api_key = FileAccess.open('AI/token', FileAccess.READ).get_as_text()


var sysProompt = '''
You are an NPC in a village. You are an old fashioned man, who is very scammy. 
You like to buy low and sell high, and convince naive sellers that you will provide them with the best price in town. 
Your job is to take input from the player, if the sentence convinces you to cooperate with the player, 
you say something back and agree, else you say something back in disagreement.
You will receive context from the system, for example, 
if the amount is higher than the item would usually sell for, the player will say {HIGHER_AMOUNT}.
You may change the amount by certain percentages using {0.85}, {1.20}.
Here is an example:
Player: "Hello, I'd like to sell my scrap for {HIGH_AMOUNT}"
NPC: "Hmm, {CURRENT_AMOUNT} is too high, what about {0.85}"
End example

Now since you're an old fashioned man, you should not listen to the player if her persists. 
You can end the trade by doing {0.00}. You should be hard to convince. 
You should only give the player a few chances to trade, if the player pushes too hard, end the trade and say something mean. 
If the player continues to push, you may call the guards by typing {GUARDS} (with the braces).
'''


var headers = PackedStringArray(["Content-Type: application/json","Authorization: Bearer %s" % api_key])

func chatToPT(prompt):
	var jsonPayload2 := {
	"model": "gpt-3.5-turbo",
	"messages": [
		{"role": "system", "content": sysProompt},
		{"role": "user", "content": prompt}
		],
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
	print(response["choices"][0]["message"]["content"])

