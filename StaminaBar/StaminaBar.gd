extends TextureProgressBar

@export var player: Player


# Called when the node enters the scene tree for the first time.
func _ready():
	player.stamina_decrease.connect(_on_player_stamina_decrease)
	player.stamina_increase.connect(_on_player_stamina_increase)
	#value = player.stamina

# Update stamina value
func _on_player_stamina_decrease():
	player.stamina -= 5
	player.stamina = clamp(player.stamina, 0, 500)
	value = player.stamina

func _on_player_stamina_increase():
	player.stamina += 1
	player.stamina = clamp(player.stamina, 0, 500)
	value = player.stamina
