#extends Area2D
class_name LightningOrb extends WeaponOrb

var upgrade_level : int = 1
var damage : int = 1
var chain_lightning : bool = true
var chain_rate : float = 0.75
var location : Vector2

func _ready() -> void:
	$Timer.timeout.connect(_on_timer_timeout)
	location = Vector2.ZERO

func _on_timer_timeout():
	lightning_strike(location)
	
func lightning_strike(location : Vector2):
	var overlapping_enemies = get_overlapping_bodies()
	if overlapping_enemies.size() > 0:
		var random_enemy = randi_range(0, overlapping_enemies.size() - 1)
		if overlapping_enemies[random_enemy].has_node("HurtBoxComponent") == true:
			var hurtbox: HurtBoxComponent = overlapping_enemies[random_enemy].get_node("HurtBoxComponent")
		
			var attack = Attack.new()
			attack.attack_damage = damage
		
			var enemy_position = overlapping_enemies[random_enemy].global_position
			#var enemy = get_tree().get_first_node_in_group("Enemy")
			#print(enemy_position)
			#print(overlapping_enemies.size())
			
			var bolt = Line2D.new()
			bolt.width = 3
			bolt.default_color = Color(255, 255, 0, 1)
			$ShootingPoint.add_child(bolt)
			
			bolt.add_point(location)
			#bolt.add_point(Vector2(200,0))
			bolt.add_point((enemy_position - $ShootingPoint.global_position) / 2)
			location = bolt.points[1]
			#bolt.add_point(enemy.global_position - $ShootingPoint.global_position)
			#print(bolt.points)
			
			hurtbox.damage(attack)
			#print("Damage dealt!")
			
			if chain_lightning == true:
				var chain_chance = randi_range(1, 100)
				if chain_chance <= chain_rate * 100:
					lightning_strike(location)
				else:
					location = Vector2.ZERO
			
			#if chain_lightning == true:
				#var chain_chance = randi_range(1, 100)
				#if chain_chance <= chain_rate * 100:
					#var bolt_area = Area2D.new()
					#bolt_area.monitoring = true
					#bolt_area.monitorable = true
					#bolt_area.collision_layer = 3
					#bolt_area.collision_mask = 3
					#var shape = CircleShape2D.new()
					#shape.set_radius($CollisionShape2D.shape.radius * 0.50)
					#var check_area = CollisionShape2D.new()
					#check_area.set_shape(shape)
					#check_area.global_position = bolt.points[1]
					#bolt_area.add_child(check_area)
					#
					#var new_enemies = bolt_area.get_overlapping_bodies()
					#
					#bolt.add_child(bolt_area)
					#
					#print(new_enemies.size(), " enemies in the sub")
					#if new_enemies.size() > 0:
						#random_enemy = randi_range(0, new_enemies.size() - 1)
						#if new_enemies[random_enemy].has_node("HurtBoxComponent") == true:
							#hurtbox = new_enemies[random_enemy].get_node("HurtBoxComponent")
							#hurtbox.damage(attack)
							#print("Sub-attack")
					
			var tween = create_tween()
			tween.tween_property(bolt, "modulate", Color.TRANSPARENT, 1)
			tween.tween_callback(bolt.queue_free)

func is_type(type): return type == "LightningOrb" or is_type(type)
func get_type(): return "LightningOrb"
