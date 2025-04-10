extends CanvasLayer

@onready var player = get_node("/root/Game/Player")
var weapon_type = null

func _ready() -> void:
	%DamageUp.pressed.connect(damage_up)
	%SpecialUp.pressed.connect(weapon_special)
	%HealthUp.pressed.connect(health_up)
	%SpeedUp.pressed.connect(speed_up)
	weapon_type = player.get_weapon_type()

func speed_up():
	player.speed_increase(0.05)
	cleanup()

func health_up():
	player.health_increase(5)
	cleanup()

func damage_up():
	pass

func weapon_special():
	pass

func cleanup():
	get_tree().paused = false
	call_deferred("queue_free")
