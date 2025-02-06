extends Node2D
class_name EnemySpawner

@export var enemy : Array[PackedScene]
var count : int

func _ready():
	%Timer.timeout.connect(_on_timer_timeout)
	count = 0

func _on_timer_timeout():
	spawn_enemy()

func spawn_enemy():
	enemy[count].instantiate()
	get_parent().call_deferred("add_child", enemy[count])
