extends Node2D
class_name Attack

var attack_damage: float
var attack_position: Vector2
var slow: bool
var freeze: bool

const SLOW_EFFECT = preload("res://statuses/slow_status_effect.tscn")

func slow_unit(unit : Enemy):
	if slow == true:
		var slowdown = SLOW_EFFECT.instantiate()
		unit.add_child(slowdown)
