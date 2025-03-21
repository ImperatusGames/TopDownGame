#extends CharacterBody2D
class_name Zombie extends Entity

@onready var player = get_node("/root/Game/Player")

func _ready() -> void:
	$HealthComponent.health_empty.connect(_on_health_empty)

func _physics_process(_delta: float) -> void:
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * %VelocityComponent.current_speed
	move_and_slide()

func _on_health_empty():
	#print("Dead unit")
	$DropRateComponent.drop_attempt()
	call_deferred("queue_free")
