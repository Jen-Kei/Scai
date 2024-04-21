extends TextureProgressBar

@onready var player = get_tree().root.get_child(1).get_child(0)

# Called when the node enters the scene tree for the first time.
func _ready():
	player.stamina_decrease.connect(_on_player_stamina_decrease)
	player.stamina_increase.connect(_on_player_stamina_increase)
	value = StatBank.currentStamina


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


# Update stamina value
func _on_player_stamina_decrease():
	StatBank.currentStamina -= 10
	StatBank.currentStamina = clamp(StatBank.currentStamina, 0, 500)
	value = StatBank.currentStamina

func _on_player_stamina_increase():
	StatBank.currentStamina += StatBank.staminaGain
	StatBank.currentStamina = clamp(StatBank.currentStamina, 0, 500)
	value = StatBank.currentStamina
