extends Panel

var itemSlotUsed = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if get_child_count() == 1 and itemSlotUsed: # No item in the slot
		print("Item removed")
		itemSlotUsed = false
		return

	if get_child_count() > 1 and !itemSlotUsed: # Item in the slot
		print("Item added")
		itemSlotUsed = true
		get_child(0).texture = get_child(1).get_node("Sprite2D").texture
		return
