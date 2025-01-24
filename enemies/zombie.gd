extends CharacterBody2D

@onready var player = get_node("/root/Level/Player")

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

#todo Add droprate function to component and then add signal emission for health_empty
