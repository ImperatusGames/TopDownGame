extends Area2D

var upgrade_level = 0
var pierce_enabled = false
var max_pierces = 0
var slow_enabled = false
var freeze_enabled = false
var damage = 1

func _ready():
	var timer = $IceShotTimer
	timer.timeout.connect(_on_iceshottimer_timeout)

func _physics_process(_delta: float) -> void:
	var enemies_in_range = get_overlapping_bodies()
	if enemies_in_range.size() > 0:
		var target_enemy = enemies_in_range.front()
		look_at(target_enemy.global_position)

func _on_iceshottimer_timeout() -> void:
	shoot()
	#print("Shoot")
	## Do I need to create a script for the timer in order to avoid using the Node Connector?

func shoot():
	const ICE_SHOT = preload("res://player/weapons/ice_shot.tscn")
	var ice_bullet = ICE_SHOT.instantiate()
	ice_bullet.damage += damage
	ice_bullet.global_rotation = %ShootingPoint.global_rotation
	ice_bullet.global_position = %ShootingPoint.global_position
	%ShootingPoint.add_child(ice_bullet)
	## Need to connect all of the variables to the newly spawned shot
