extends TextureProgressBar

@export var player: Player

@onready var staminaBar = $StaminaBar/TextureProgressBar
@onready var statBank = get_tree().root.get_child(0).get_child(0).get_node("StatBank")



# Called when the node enters the scene tree for the first time.
func _ready():
	player.stamina_decrease.connect(_on_player_stamina_decrease)
	player.stamina_increase.connect(_on_player_stamina_increase)
	#value = player.stamina


# Update stamina value
func _on_player_stamina_decrease():
	var staminaCapacity = statBank.stamina_capacity
	var staminaGain = statBank.stamina_gain
	player.stamina -= staminaGain
	player.stamina = clamp(player.stamina, 0, staminaCapacity)
	value = player.stamina

func _on_player_stamina_increase():
	var staminaCapacity = statBank.stamina_capacity
	var staminaGain = statBank.stamina_gain
	player.stamina += staminaGain
	player.stamina = clamp(player.stamina, 0, staminaCapacity)
	value = player.stamina
