extends Node2D
class_name HealthComponent

@export var MAX_HEALTH = 10
@export var current_health : int
signal health_empty

func _ready():
	current_health = MAX_HEALTH
	
func damage(attack: Attack):
	current_health -= attack.attack_damage
	
	if current_health <= 0:
		health_empty.emit()
