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
