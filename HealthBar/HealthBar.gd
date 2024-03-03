extends TextureProgressBar

@export var player: Player


# Called when the node enters the scene tree for the first time.
func _ready():
	player.health_decrease.connect(_on_player_health_decrease)
	player.health_increase.connect(_on_player_health_increase)
	#value = player.health

# Update health value
func _on_player_health_decrease():
	player.health -= 10
	player.health = clamp(player.health, 0, player.health_capacity)
	value = player.health

func _on_player_health_increase():
	player.health += player.health_gain
	player.health = clamp(player.health, 0, player.health_capacity)
	value = player.health
