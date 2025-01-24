extends Node2D
class_name VelocityComponent

@export var BASE_SPEED : float
@export var current_speed : float

func _ready():
	current_speed = BASE_SPEED
