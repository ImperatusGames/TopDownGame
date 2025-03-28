extends CanvasLayer

@onready var player = get_node("/root/Game/Player")

func _ready() -> void:
	%HealthUp.pressed.connect(health_up)
	%SpeedUp.pressed.connect(speed_up)

func speed_up():
	player.speed_increase(0.05)
	cleanup()

func health_up():
	player.health_increase(5)
	cleanup()

func cleanup():
	get_tree().paused = false
	call_deferred("queue_free")
