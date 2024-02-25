extends Panel

var itemSlotUsed = false
@onready var statBank = get_parent().get_parent().get_parent().get_node("StatBank")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if get_child_count() == 1 and itemSlotUsed: # No item in the slot
		print("Item removed from slot")
		itemSlotUsed = false
		get_child(0).texture = null
		return

	if get_child_count() > 1 and !itemSlotUsed: # Item in the slot
		print("Item added to slot")
		itemSlotUsed = true
		var item = get_child(1)
		get_child(0).texture = item.get_node("Sprite2D").texture
		statBank.appendStats(item._itemDetails, true)
		# Update stats

		return
