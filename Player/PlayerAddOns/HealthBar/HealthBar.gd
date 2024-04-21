extends TextureProgressBar

@onready var player = get_tree().root.get_child(1).get_child(0)

# Called when the node enters the scene tree for the first time.
func _ready():
	player.health_decrease.connect(_on_player_health_decrease)
	player.health_increase.connect(_on_player_health_increase)
	value = StatBank.currentHealth


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


# Update stamina value
func _on_player_health_decrease():
	StatBank.currentHealth -= 10
	StatBank.currentHealth = clamp(StatBank.currentHealth, 0, 500)
	value = StatBank.currentHealth

func _on_player_health_increase():
	StatBank.currentHealth += StatBank.healthGain
	StatBank.currentHealth = clamp(StatBank.currentHealth, 0, 500)
	value = StatBank.currentHealth
