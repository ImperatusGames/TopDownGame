#extends Area2D
class_name IceOrb extends WeaponOrb

var upgrade_level := 0
var slow_enabled := false
var pierce_enabled := false
var max_pierces := 0
var freeze_enabled := false
var slow_chance := 0.25
var freeze_chance := 0.1
var damage := 0

func _ready():
	var timer = $IceShotTimer
	timer.timeout.connect(_on_iceshottimer_timeout)

func _physics_process(_delta: float) -> void:
	var enemies_in_range = get_overlapping_bodies()
	#if enemies_in_range.size() > 0:
	#var target_enemy = enemies_in_range.front()
	#if target_enemy != null:
		#look_at(target_enemy.global_position)
	if enemies_in_range.size() > 0:
		enemies_in_range.sort_custom(func(a, b):
			return a.global_position.distance_squared_to(global_position) < b.global_position.distance_squared_to(global_position)
			)
		var target_enemy = enemies_in_range.front()
		if target_enemy != null:
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
	ice_bullet.pierce_enabled = pierce_enabled
	ice_bullet.max_pierces = max_pierces
	ice_bullet.slow_enabled = slow_enabled
	ice_bullet.freeze_enabled = freeze_enabled
	ice_bullet.slow_chance = slow_chance
	ice_bullet.freeze_chance = freeze_chance
	%ShootingPoint.add_child(ice_bullet)
	## Need to connect all of the variables to the newly spawned shot

func is_type(type): return type == "IceOrb" or is_type(type)
func get_type(): return "IceOrb"

func get_slow_rate():
	return slow_chance

func get_freeze_rate():
	return freeze_chance
