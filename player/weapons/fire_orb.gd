extends Area2D

var upgrade_level = 1
var damage = 0

func _ready() -> void:
	$Timer.timeout.connect(_on_timer_timeout)

func _physics_process(delta: float) -> void:
	%ShootingPoint.rotation += (1 * delta)
	#$FireOrbSprite.rotation += (1 * delta)

func shoot():
	const FIREBALL = preload("res://player/weapons/fireball.tscn")
	var new_fireball = FIREBALL.instantiate()
	new_fireball.global_position = %ShootingPoint.global_position
	new_fireball.global_rotation = %ShootingPoint.global_rotation
	new_fireball.damage += damage
	%ShootingPoint.add_child(new_fireball)

func _on_timer_timeout() -> void:
	shoot()
	#print("Fireball spawned")
