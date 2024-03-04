extends Sprite2D

@export var bullet_speed = 1900.0
@export var bps = 40
@export var bullet_damage = 30
@export var total_ammo = 100000
@export var CLIP_SIZE = 1000000
@export var current_ammo = CLIP_SIZE

var time_until_fire = 0
var fire_rate = 1.0/bps

var bullet_scn = preload("res://Gun/Bullet/Bullet.tscn")
#var _particle = preload("res://Gun/Bullet/Bullet.tscn")
var gun_scn = load("res://Gun/gun.tscn")

@onready var anim = $pickUpObj/pickupPanel/AnimationPlayer
@onready var player = get_tree().root.get_node("PlayerX")
@onready var gunSlot = player.get_node("Marker2D").get_node("gunSlot")

var closeToGun = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _ready():
	print("Gun ready")
	print(get_parent().name)
	get_child(0).visible = false


func _process(delta):
	if get_parent().name == "Objects": # If the gun is on the floor
		if player.position.distance_to(self.position) < 100:
			closeToGun = true
			if Input.is_key_pressed(KEY_E):
				var newGun = gun_scn.instantiate()
				newGun.scale = Vector2(0.3, 0.3)
				newGun.visible = false
				gunSlot.add_child(newGun)
				self.queue_free()
			if closeToGun:
				anim.play("floating")
				get_child(0).visible = true
		else:
			get_child(0).visible = false
			closeToGun = false
		return # End function right here
		
	time_until_fire = max(0, time_until_fire - delta)
	if get_parent().get_parent().name == "Turret":
		return
	
	if(Input.is_key_pressed(KEY_Q)):
		pass
		#dropWeapon()
	elif(Input.is_key_pressed(KEY_R)):
		reload()
	
	#if Input.is_action_just_pressed("click"):
	if Input.is_action_pressed("click"):
		fire(player.get_node("Marker2D").get_node("gunSlot").global_position)
	
	
	#print(time_until_fire)

func fire(pos:Vector2):
	if(time_until_fire == 0 and current_ammo > 0):
		print("Fire")
		$gunShot.play()
		#var particle = _particle.instantiate()
		#particle.position = global_position
		#particle.rotation = global_rotation
		#particle.emitting = true
		#get_tree().current_scene.add_child(particle)

		print(self.name)
		var bullet = RigidBody2D.new()
		bullet = bullet_scn.instantiate()
		bullet.rotation = global_rotation
		bullet.global_position = pos
		bullet.linear_velocity = bullet.transform.x * bullet_speed

		get_tree().root.add_child(bullet)
		time_until_fire = fire_rate
		current_ammo = current_ammo - 1
	
func dropWeapon():
	var newGun = gun_scn.instantiate()
	newGun.position = global_position
	newGun.rotation = global_rotation
	# Keep pickupPanel upright
	var pickupPanel = newGun.get_node("pickUpObj")
	pickupPanel.rotation_degrees = -newGun.rotation_degrees  # Use newGun rotation
	pickupPanel.position = Vector2(0, 0)
	get_tree().current_scene.get_node("Objects").add_child(newGun)
	self.queue_free()

func reload():
	current_ammo = CLIP_SIZE
