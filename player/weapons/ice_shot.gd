extends Area2D

var travelled_distance := 0
var pierce_enabled := false
var max_pierces := 0
var pierce_count := 0
var damage := 0
var slow_enabled := false
var freeze_enabled := false
var slow_chance := 0.25
var freeze_chance := 0.1

#signal hurtbox_area_entered

func _ready():
	#Manually connects signal to detect body collisions
	area_entered.connect(_on_area_entered)

func _physics_process(delta: float) -> void:
	const SPEED = 350
	const RANGE = 1000
	
	var direction = Vector2.RIGHT.rotated(rotation)
	position += direction * SPEED * delta
	
	travelled_distance += SPEED * delta
	
	if travelled_distance > RANGE:
		queue_free()

#func _on_body_entered(body: Node2D) -> void:
	#queue_free()
	#if pierce_enabled == false:
		#queue_free()
	#else:
		#if pierce_count == max_pierces:
			#queue_free()
		#else:
			#pierce_count += 1
	#if freeze_enabled == true:
		#if body.has_method("get_frozen"):
			#var freeze_chance = randf()
			#if freeze_chance <= 0.05:
				#body.get_frozen()
			

func _on_area_entered(area) -> void:
	if area is HurtBoxComponent:
		var hurtbox: HurtBoxComponent = area
		
		var attack = Attack.new()
		attack.attack_damage = damage
		
		if slow_enabled == true:
			var slow_roll = randi_range(0, 100)
			print("Slow chance: ", slow_roll)
			if slow_roll <= slow_chance * 100:
				attack.slow = true
				print("Slow success: ", attack.slow)
				attack.slow_unit(hurtbox.get_parent())
			
		if freeze_enabled == true:
			var freeze_roll = randi_range(0, 100)
			print("Freeze chance: ", freeze_roll)
			if freeze_roll <= freeze_chance * 100:
				attack.freeze = true
				print("Freeze success: ", attack.freeze)
				attack.freeze_unit(hurtbox.get_parent())
			
		hurtbox.damage(attack)
		#print("Damage dealt!")
		queue_free()

#func _slow_check(area):
	#if area.get_parent().get_node("VelocityComponent").slowable == true:
		#return true
		#print("true")
	#else:
		#return false
		#print("false")
