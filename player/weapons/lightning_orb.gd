extends Area2D

var upgrade_level = 1
var damage = 1

func _ready() -> void:
	$Timer.timeout.connect(_on_timer_timeout)

func _on_timer_timeout():
	lightning_strike()
	
func lightning_strike():
	var overlapping_enemies = get_overlapping_bodies()
	if overlapping_enemies.size() > 0:
		var random_enemy = randi_range(0, overlapping_enemies.size() - 1)
		if overlapping_enemies[random_enemy].has_node("HurtBoxComponent") == true:
			var hurtbox: HurtBoxComponent = overlapping_enemies[random_enemy].get_node("HurtBoxComponent")
		
			var attack = Attack.new()
			attack.attack_damage = damage
		
			var enemy_position = overlapping_enemies[random_enemy].global_position
			#var enemy = get_tree().get_first_node_in_group("Enemy")
			print(enemy_position)
			#print(overlapping_enemies.size())
			
			var bolt = Line2D.new()
			bolt.width = 3
			bolt.default_color = Color(255, 255, 0, 1)
			$ShootingPoint.add_child(bolt)
			
			bolt.add_point(Vector2.ZERO)
			#bolt.add_point(Vector2(200,0))
			bolt.add_point((enemy_position - $ShootingPoint.global_position) / 2)
			#bolt.add_point(enemy.global_position - $ShootingPoint.global_position)
			print(bolt.points)
			
			hurtbox.damage(attack)
			print("Damage dealt!")
						
			var tween = get_tree().create_tween()
			tween.tween_property(bolt, "modulate", Color.TRANSPARENT, 1)
			tween.tween_callback(bolt.queue_free)
