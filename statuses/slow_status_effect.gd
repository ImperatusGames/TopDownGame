extends Node2D
class_name StatusEffect

@onready var speed = get_parent().get_node("VelocityComponent").current_speed

func _ready() -> void:
	$Timer.timeout.connect(_on_slow_timeout)
	$timer.start()
	_timer_started()

func _timer_started():
	speed = speed / 2
	print(speed, " is current speed")

func _on_slow_timeout():
	speed = get_parent().get_node("VelocityComponent").BASE_SPEED
	queue_free()


####Rewrite functionality as follows
# Check if enemy is already slowed status effect instance
# If not, instantiate slow
# If it does, restart slow timer
####
