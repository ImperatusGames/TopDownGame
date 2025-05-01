#extends CharacterBody2D
class_name Player extends Entity

var player_xp := 0
var level := 1
var xp_to_level := 3
var weapon_array : Array[WeaponOrb]

@onready var health_component: HealthComponent = %HealthComponent
@onready var velocity_component: VelocityComponent = %VelocityComponent

signal xp_changed
signal level_up_signal
signal health_depleted

func _ready() -> void:
	health_component.connect("health_empty", zero_health)
	#pass

func _process(delta: float) -> void:
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * velocity_component.current_speed
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
		health_component.damage(attack)
		print(health_component.current_health)

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
		#if weapon_array.size() == 0 or weapon_array[0].is_class("FireOrb"):
		if weapon_array.size() < 8:
			weapon_array.append(weapon)
			#print("Fire Orb added to weapon array!")
			#print(weapon_array.size())
			add_child(weapon)
			if weapon_array.size() > 1:
				for i in range(0, weapon_array.size()):
					var x = (((PI * 2) / weapon_array.size()) * i)
					weapon_array[i].shooting_point_rotation(x)
					weapon_array[i].reset_timer()
					weapon_array[i].upgrade_level += 1
					
		else:
			#print("Too many in the array! Can't add any more.")
			pass
	elif weapon.get_type() == "IceOrb":
		if weapon_array == null or weapon_array.size() == 0:
			weapon_array.append(weapon)
			add_child(weapon)
		else:
			#print("Too many in the array! Can't add any more.")
			pass
	elif weapon.get_type() == "LightningOrb":
		if weapon_array == null or weapon_array.size() == 0:
			weapon_array.append(weapon)
			add_child(weapon)
		else:
			#print("Too many in the array! Can't add any more.")
			pass
	else:
		pass

func speed_increase(val):
	velocity_component.speed_mod += val
	print(velocity_component.speed_mod)

func health_increase(val):
	health_component.max_health += val
	print(health_component.max_health)

func damage_increase(val):
	for i in range(weapon_array.size()):
		weapon_array[i].damage += val
		weapon_array[i].upgrade_level += 1
		print(weapon_array[i].damage)

func zero_health():
	emit_signal("health_depleted")

func get_weapon_type():
	if weapon_array == null:
		print("Null")
		return null
	elif weapon_array[0].get_type() == "FireOrb":
		print("Fire Orb")
		return "FireOrb"
	elif weapon_array[0].get_type() == "IceOrb":
		print("Ice Orb")
		return "IceOrb"
	elif weapon_array[0].get_type() == "LightningOrb":
		print("Lightning Orb")
		return "LightningOrb"
	else:
		print("Error")
		return "Error"

func get_weapon_level():
	return weapon_array[0].upgrade_level

func get_weapon_size():
	return weapon_array.size()

func get_lightning_states():
	var states = []
	states.append(weapon_array[0].chain_lightning)
	states.append(weapon_array[0].chain_rate)
	
	return states

func get_fire_states():
	var states = []
	states.append(weapon_array[0].explosions)
	
	return states

func get_ice_states():
	var states = []
	states.append(weapon_array[0].slow_enabled)
	states.append(weapon_array[0].pierce_enabled)
	states.append(weapon_array[0].max_pierces)
	states.append(weapon_array[0].freeze_enabled)
	states.append(weapon_array[0].slow_chance)
	states.append(weapon_array[0].freeze_chance)
	
	return states

func enable_explosions():
	for i in range(weapon_array.size()):
		weapon_array[i].explosions = true
	upgrade_level_increase()

func enable_slow():
	weapon_array[0].slow_enabled = true
	upgrade_level_increase()
	
func enable_pierce():
	weapon_array[0].pierce_enabled = true
	weapon_array[0].max_pierces = 1
	#upgrade_level_increase()
	
func enable_freeze():
	weapon_array[0].freeze_enabled = true
	#upgrade_level_increase()

func enable_chain_lightning():
	weapon_array[0].chain_lightning = true
	#upgrade_level_increase()
	
func pierce_increase():
	weapon_array[0].max_pierces += 1
	#upgrade_level_increase()
	
func upgrade_level_increase():
	for i in range(weapon_array.size()):
		weapon_array[i].upgrade_level += 1
