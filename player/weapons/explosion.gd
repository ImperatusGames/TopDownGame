extends Area2D

var damage := 1

func _ready() -> void:
	%Timer.timeout.connect(_on_timer_timeout)
	
	explode()
	
func explode():
	var bodies = get_overlapping_bodies()
	print(bodies.size(), " bodies in explosion")
	if bodies.size() > 0:
		var attack = Attack.new()
		attack.attack_damage = damage
		
		for i in bodies:
			if bodies[i].has_node("HurtBoxComponent") == true:
				var hurtbox: HurtBoxComponent = bodies[i].get_node("HurtBoxComponent")
				hurtbox.damage(attack)

func _on_timer_timeout():
	queue_free()
