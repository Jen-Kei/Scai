import json
FILENAME = "C:\\Code\\Kei&Jei\\Treasures\\Treasures.json"

class btnData:
	def __init__(self, value):
		self.value = value

# Read the JSON data from the file
with open(FILENAME, 'r') as file:
    json_data = file.read()

# Parse the JSON data into a Python object
data = json.loads(json_data)

print(data['Items']['Rarity']['Common'].keys())