extends Area2D
class_name WeaponComponent

@export var BASE_DAMAGE: int
@export var current_damage: int

func _ready():
	current_damage = BASE_DAMAGE
