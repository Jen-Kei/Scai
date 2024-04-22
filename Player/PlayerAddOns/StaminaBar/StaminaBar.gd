extends TextureProgressBar

@onready var player = get_tree().root.get_child(2).get_child(0)

# Called when the node enters the scene tree for the first time.
func _ready():
	player.stamina_decrease.connect(_on_player_stamina_decrease)
	player.stamina_increase.connect(_on_player_stamina_increase)
	value = Globals.currentStamina


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


# Update stamina value
func _on_player_stamina_decrease():
	Globals.currentStamina -= 10
	Globals.currentStamina = clamp(Globals.currentStamina, 0, 500)
	value = Globals.currentStamina

func _on_player_stamina_increase():
	Globals.currentStamina += Globals.staminaGain
	Globals.currentStamina = clamp(Globals.currentStamina, 0, 500)
	value = Globals.currentStamina
