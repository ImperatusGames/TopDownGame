#extends CharacterBody2D
class_name Mage extends Entity

@onready var player = get_node("/root/Game/Player")

func _ready() -> void:
	$HealthComponent.health_empty.connect(_on_health_empty)
	%Timer.timeout.connect(_on_timer_timeout)

func _physics_process(_delta: float) -> void:
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * %VelocityComponent.current_speed
	move_and_slide()

func _on_health_empty():
	#print("Dead unit")
	$DropRateComponent.drop_attempt()
	call_deferred("queue_free")

func _on_timer_timeout():
	shoot()

func shoot():
	const FIREBALL = preload("res://player/weapons/fireball.tscn")
	var new_fireball = FIREBALL.instantiate()
	var direction = (player.global_position - global_position).normalized()
	new_fireball.global_position = global_position
	new_fireball.global_rotation = direction.angle() #+ PI / 2.0
	new_fireball.collision_layer = 3
	new_fireball.collision_mask = 3
	new_fireball.damage = %DamageComponent.BASE_DAMAGE_RATE * 2
	add_child(new_fireball)
