extends Node2D

@onready var weightMultiplier = 1.5
@onready var speed = 100.0
@onready var normal_speed = 100.0
@onready var extra_speed = 200.0
@onready var stamina = 500
@onready var stamina_capacity = 500
@onready var stamina_gain = 5

@onready var health_capacity = 500
@onready var health_gain = 5
@onready var health = 100

@onready var weight = 1
@onready var weight_capacity = 100

@onready var fire_rate = 30

var weightItems = []


func appendStats(details, add):
	if add:
		weight += details["Weight"] * weightMultiplier
		print("Added weight: ", weight)

		var new_speed = 100 - weight
		speed = new_speed
		normal_speed = new_speed
		extra_speed = new_speed

		stamina_capacity = stamina_capacity * details["StaminaCapacity"]
		stamina_gain = stamina_gain * details["StaminaGain"]

		health_capacity = health_capacity * details["HealthCapacity"]
		health_gain = health_gain * details["HealthGain"]

		weight_capacity = weight_capacity * details["WeightCapacity"]

		fire_rate = fire_rate * details["FireRate"]
	else:
		weight -= details["Weight"] * weightMultiplier
		print("Dropped weight: ", weight)

		var new_speed = 100 - weight
		speed = new_speed
		normal_speed = new_speed
		extra_speed = new_speed

		stamina_capacity = stamina_capacity / details["StaminaCapacity"]
		stamina_gain = stamina_gain / details["StaminaGain"]

		health_capacity = health_capacity / details["HealthCapacity"]
		health_gain = health_gain / details["HealthGain"]

		weight_capacity = weight_capacity / details["WeightCapacity"]

		fire_rate = fire_rate / details["FireRate"]
	
	get_parent().reInit()
