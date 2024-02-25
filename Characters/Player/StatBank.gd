extends Node2D

@onready var speed = 100.0
@onready var normal_speed = 100.0
@onready var extra_speed = 200.0
@onready var stamina = 500
@onready var stamina_capacity = 500
@onready var stamina_gain = 5

@onready var health_capacity = 100
@onready var health_gain = 5
@onready var health = 100

@onready var weight = 0
@onready var weight_capacity = 100

@onready var fire_rate = 30


func appendStats(details, add):
    if add:
        speed = speed * details["speed"]
        normal_speed = normal_speed * details["speed"]
        extra_speed = extra_speed * details["speed"]

        stamina_capacity = stamina_capacity * details["StaminaCapacity"]
        stamina_gain = stamina_gain * details["StaminaGain"]

        health_capacity = health_capacity * details["HealthCapacity"]
        health_gain = health_gain * details["HealthGain"]

        weight = weight * details["Weight"]
        weight_capacity = weight_capacity * details["WeightCapacity"]

        fire_rate = fire_rate * details["FireRate"]
    else:
        speed = speed / details["speed"]
        normal_speed = normal_speed / details["speed"]
        extra_speed = extra_speed / details["speed"]

        stamina_capacity = stamina_capacity / details["StaminaCapacity"]
        stamina_gain = stamina_gain / details["StaminaGain"]

        health_capacity = health_capacity / details["HealthCapacity"]
        health_gain = health_gain / details["HealthGain"]

        weight = weight / details["Weight"]
        weight_capacity = weight_capacity / details["WeightCapacity"]

        fire_rate = fire_rate / details["FireRate"]
    
    get_parent().reInit()
