extends Area2D

var damage := 1
var explosion_scale := 1.0

func _ready() -> void:
	%Timer.timeout.connect(_on_timer_timeout)
	%DamageTimer.timeout.connect(_disable_damage_timeout)
	area_entered.connect(_on_area_entered)
	scale.x = explosion_scale
	scale.y = explosion_scale

func _on_timer_timeout():
	queue_free()

func _disable_damage_timeout():
	area_entered.disconnect(_on_area_entered)

func _on_area_entered(area):
	if area is HurtBoxComponent:
		var hurtbox: HurtBoxComponent = area
		
		var attack = Attack.new()
		attack.attack_damage = damage
		
		hurtbox.damage(attack)
