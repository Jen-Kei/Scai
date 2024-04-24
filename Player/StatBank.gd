extends Node2D

#@onready var weightMultiplier = 1.5
#@onready var speed = 100.0
#@onready var normal_speed = 100.0
#@onready var extra_speed = 200.0
#@onready var stamina = 500
#@onready var stamina_capacity = 500
#@onready var stamina_gain = 5
#
#@onready var health_capacity = 500
#@onready var health_gain = 5
#@onready var health = 100
#
#@onready var weight = 1
#@onready var weight_capacity = 100
#
#@onready var fire_rate = 30

var weightItems = []

func appendStats(details, add):
	if add:
		# Append the stats
		Globals.normalSpeed = Globals.normalSpeed * details["Speed"]
		#Globals.extraSpeed = Globals.extraSpeed * details["ExtraSpeed"]

		Globals.maxStamina = Globals.maxStamina * details["MaxStamina"]
		Globals.staminaGain = Globals.staminaGain * details["StaminaGain"]

		Globals.maxHealth = Globals.maxHealth * details["MaxHealth"]
		Globals.healthGain = Globals.healthGain * details["HealthGain"]

		Globals.fireRate = Globals.fireRate * details["FireRate"]
		print("adding stats normalSpeed, maxStamina, staminaGain, maxHealth, healthGain, fireRate", Globals.normalSpeed, Globals.maxStamina, Globals.staminaGain, Globals.maxHealth, Globals.healthGain, Globals.fireRate)
		print(details)
	else:
		# Remove the stats
		Globals.normalSpeed = Globals.normalSpeed / details["Speed"]

		Globals.maxStamina = Globals.maxStamina / details["MaxStamina"]
		Globals.staminaGain = Globals.staminaGain / details["StaminaGain"]

		Globals.maxHealth = Globals.maxHealth / details["MaxHealth"]
		Globals.healthGain = Globals.healthGain / details["HealthGain"]

		Globals.fireRate = Globals.fireRate / details["FireRate"]
	