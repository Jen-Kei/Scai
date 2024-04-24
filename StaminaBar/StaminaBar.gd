extends TextureProgressBar

@onready var player = get_tree().root.get_node("PlayerX")

#@onready var staminaPerSecond = 1.0

# Called when the node enters the scene tree for the first time.
func _ready():
	player.stamina_decrease.connect(_on_player_stamina_decrease)
	player.stamina_increase.connect(_on_player_stamina_increase)
	value = Globals.currentStamina

# Update stamina value
func _on_player_stamina_decrease():
	max_value = Globals.maxStamina
	Globals.currentStamina -= Globals.staminaGain
	Globals.currentStamina = clamp(Globals.currentStamina, 0, max_value)
	value = Globals.currentStamina

func _on_player_stamina_increase():
	Globals.currentStamina += Globals.staminaGain
	Globals.currentStamina = clamp(Globals.currentStamina, 0, Globals.maxHealth)
	value = Globals.currentStamina
