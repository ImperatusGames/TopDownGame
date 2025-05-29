extends Node2D
class_name Attack

var attack_damage: int
var attack_position: Vector2
var slow: bool
var freeze: bool

const SLOW_EFFECT = preload("res://statuses/slow_status_effect.tscn")
const FREEZE_EFFECT = preload("res://statuses/freeze_status_effect.tscn")

func slow_unit(unit : Entity):
	if slow == true:
		var slowdown = SLOW_EFFECT.instantiate()
		unit.add_child(slowdown)

func freeze_unit(unit : Entity):
	if slow == true:
		var frozen = FREEZE_EFFECT.instantiate()
		unit.add_child(frozen)
