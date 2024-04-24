extends TextureProgressBar

signal game_over
@onready var player = get_tree().root.get_node("PlayerX")


#@onready var healthPerSecond = 1.0

# Called when the node enters the scene tree for the first time.
func _ready():
	player.health_decrease.connect(_on_player_health_decrease)
	player.health_increase.connect(_on_player_health_increase)
	value = Globals.currentHealth

func _process(delta):
	value = Globals.currentHealth

# Update health value
func _on_player_health_decrease():
	max_value = Globals.maxHealth
	Globals.currentHealth -= 70
	Globals.currentHealth = clamp(Globals.currentHealth, 0, max_value)
	value = Globals.currentHealth
	if value <= 0:
		Globals.gameOverMessage = "Why so quiet? Cat got your tongue?"
		game_over.emit()

func _on_player_health_increase():
	Globals.currentHealth += Globals.healthGain
	Globals.currentHealth = clamp(Globals.currentHealth, 0, Globals.maxHealth)
	value = Globals.currentHealth
