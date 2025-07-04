#extends Area2D
class_name FireOrb extends WeaponOrb

var upgrade_level := 0
var damage := 0
var explosions := false
var explosion_scale := 1.0

func _ready() -> void:
	$Timer.timeout.connect(_on_timer_timeout)

func _physics_process(delta: float) -> void:
	%ShootingPoint.rotation += (1.2 * delta)
	#$FireOrbSprite.rotation += (1 * delta)

func shoot():
	const FIREBALL = preload("res://player/weapons/fireball.tscn")
	var new_fireball = FIREBALL.instantiate()
	new_fireball.global_position = %FireOrbSprite.global_position
	new_fireball.global_rotation = %FireOrbSprite.global_rotation
	#new_fireball.collision_layer
	#new_fireball.collision_mask
	new_fireball.damage += damage
	new_fireball.explosions = explosions
	new_fireball.explosion_scale = explosion_scale
	%FireOrbSprite.add_child(new_fireball)
	AudioManager.play_weapon_sfx("res://audio/Small Fireball Cast A.wav", 0.25)

func _on_timer_timeout() -> void:
	shoot()
	#print("Fireball spawned")

func is_type(type): return type == "FireOrb" or is_type(type)
func get_type(): return "FireOrb"

func shooting_point_rotation(val):
	%ShootingPoint.rotation = val

func reset_timer():
	%Timer.start()
