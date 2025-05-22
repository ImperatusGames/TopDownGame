extends Node2D
class_name EnemySpawner

@onready var path: PathFollow2D = %PathFollow2D
@export var enemy : Array[PackedScene]
var count : int

func _ready():
	%Timer.timeout.connect(_on_timer_timeout)
	count = 0

func _on_timer_timeout():
	spawn_enemy()

func spawn_enemy():
	path.progress_ratio = randf()
	var new_enemy = enemy[count].instantiate()
	new_enemy.global_position = path.global_position
	call_deferred("add_child", new_enemy)

func start_timer(duration: float = 2.0):
	%Timer.start(duration)

func is_active():
	if %Timer.is_stopped() == true:
		return false
	else:
		return true

func reduce_timer(reduction: float = 0.1):
	%Timer.wait_time -= reduction
