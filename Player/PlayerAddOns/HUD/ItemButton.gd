extends PanelContainer
var itemValue = 0
var pressedDown = false
var itemSlot

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_button_down():
	print(itemSlot)
	pressedDown = !pressedDown
	if pressedDown:
		get_node("Button").modulate = Color(1, 0, 0, 1)
	else:
		get_node("Button").modulate = Color(1, 1, 1, 1)