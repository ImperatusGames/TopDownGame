#extends CharacterBody2D
class_name Player extends Entity

var player_xp := 0
var level := 1
var xp_to_level := 3
var weapon_array : Array[WeaponOrb]

#const XP_COIN = preload("res://assets/xp_coin.tscn")
@onready var health_component: HealthComponent = %HealthComponent

signal xp_changed
signal level_up_signal
signal health_depleted

func _ready() -> void:
	health_component.connect("health_empty", zero_health)
	#pass

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
	emit_signal("xp_changed")
	get_experience()

func get_experience():
	if player_xp == xp_to_level:
		level_up()
	else:
		print("XP to level: " + str(xp_to_level - player_xp))

func level_up():
	emit_signal("level_up_signal")
	player_xp = 0
	level += 1
	xp_to_level += 2
	health_component.heal()
	print("LEVEL UP! -- -- Player leveled up to level " + str(level) + " -- --")
	emit_signal("xp_changed")

func add_weapon_orb(weapon: WeaponOrb):
	print(weapon.get_type())
	
	if weapon.get_type() == "FireOrb":
		#if weapon_array == null or weapon_array[0].is_class("FireOrb"):
		if weapon_array.size() < 8:
			weapon_array.append(weapon)
			print("Fire Orb added to weapon array!")
			print(weapon_array.size())
			#TODO Add the child to the player's tree and then set global position based on the number of fire orbs already there
			#TODO Can we link the child in the tree to the item in the array?
		else:
			print("Too many in the array! Can't add any more.")
	elif weapon.get_type() == "IceOrb":
		if weapon_array == null:
			weapon_array.append(weapon)
	elif weapon.get_type() == "LightningOrb":
		if weapon_array == null:
			weapon_array.append(weapon)
	else:
		pass

func speed_increase(val):
	%VelocityComponent.speed_mod += val
	print(%VelocityComponent.speed_mod)

func health_increase(val):
	health_component.max_health += val
	print(health_component.max_health)

func zero_health():
	emit_signal("health_depleted")
