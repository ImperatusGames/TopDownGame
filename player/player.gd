extends CharacterBody2D
class_name Player

var player_xp : int = 0
var level : int = 1
var xp_to_level = 3

#const XP_COIN = preload("res://assets/xp_coin.tscn")
@onready var health_component: HealthComponent = %HealthComponent

#func _ready() -> void:
	#XP_COIN.experience_gain.connect(_on_experience_gain)

func _process(delta: float) -> void:
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * %VelocityComponent.current_speed
	move_and_slide()

	var damage_rate: float = 0.0
	var overlapping_enemies = %HurtBoxComponent.get_overlapping_bodies()
	
	for enemy in overlapping_enemies:
		if enemy.has_node("DamageComponent") == true:
			damage_rate += enemy.get_node("DamageComponent").current_damage_rate
			#print("Damage component exists")
			#print(damage_rate)
			
	if overlapping_enemies.size() > 0:
		#%HealthComponent.current_health -= damage_rate * delta
		var attack = Attack.new()
		attack.attack_damage = damage_rate*delta
		%HealthComponent.damage(attack)
		print(%HealthComponent.current_health)

func on_experience_gain(experience):
	player_xp += experience
	get_experience()

func get_experience():
	if player_xp == xp_to_level:
		level_up()
	else:
		print("XP to level: " + str(xp_to_level - player_xp))

func level_up():
	player_xp = 0
	level += 1
	xp_to_level += 2
	%HealthComponent.current_health = %HealthComponent.MAX_HEALTH
	print("Player leveled up to level " + str(level))
