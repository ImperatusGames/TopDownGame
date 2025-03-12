extends Node2D
class_name HealthComponent

@export var MAX_HEALTH = 10
@export var current_health : int

signal health_empty
signal health_changed(current_health)

func _ready():
	current_health = MAX_HEALTH
	emit_signal("health_changed", current_health)
	
func damage(attack: Attack):
	current_health -= attack.attack_damage
	emit_signal("health_changed", current_health)
	
	if current_health <= 0:
		health_empty.emit()
		
func heal():
	current_health = MAX_HEALTH
	emit_signal("health_changed", current_health)
