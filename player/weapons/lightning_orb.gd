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
		
	#TODO Look at a Tween in order to create a way to queue_free the line after X time has passed
	#TODO Add damage
		
	#for enemy in overlapping_enemies:
		#if enemy.has_node("DamageComponent") == true:
			#damage_rate += enemy.get_node("DamageComponent").current_damage_rate
			#print("Damage component exists")
			#print(damage_rate)
			
	#if overlapping_enemies.size() > 0:
		#%HealthComponent.current_health -= damage_rate * delta
		#print(%HealthComponent.current_health)
