extends TextureProgressBar

@onready var player = get_tree().root.get_child(2).get_child(0)

# Called when the node enters the scene tree for the first time.
func _ready():
	player.health_decrease.connect(_on_player_health_decrease)
	player.health_increase.connect(_on_player_health_increase)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


# Update stamina value
func _on_player_health_decrease():
	Globals.currentHealth -= 10
	Globals.currentHealth = clamp(Globals.currentHealth, 0, 500)
	value = Globals.currentHealth

func _on_player_health_increase():
	Globals.currentHealth += Globals.healthGain
	Globals.currentHealth = clamp(Globals.currentHealth, 0, 500)
	value = Globals.currentHealth
