extends Node2D
class_name VelocityComponent

@export var BASE_SPEED : float
@export var current_speed : float
@export var slowable : bool

func _ready():
	current_speed = BASE_SPEED

func can_be_slowed():
	if slowable == true:
		return true
	else:
		return false
