extends Area2D

var travelled_distance := 0
var damage := 1
var explosions := false
var explosion_damage := 1
var explosion_scale := 1.0

func _ready() -> void:
	area_entered.connect(_on_area_entered)
	print(damage)
	
func _physics_process(delta: float) -> void:
	const SPEED = 300
	const RANGE = 600
	
	var direction = Vector2.RIGHT.rotated(rotation)
	position += direction * SPEED * delta
	
	travelled_distance += SPEED * delta
	
	if travelled_distance > RANGE:
		queue_free()
		
func _on_area_entered(area) -> void:
	if area is HurtBoxComponent:
		var hurtbox: HurtBoxComponent = area
		
		var attack = Attack.new()
		attack.attack_damage = damage
		
		hurtbox.damage(attack)
		
		if explosions == true:
			explosion()
			
			#var tween = create_tween()
			#tween.tween_property(new_explosion, "modulate", Color.TRANSPARENT, 1)
			#tween.tween_callback(new_explosion.queue_free)
		
		#print("Damage dealt!")
		queue_free()

func explosion():
	const EXPLOSION = preload("res://player/weapons/explosion.tscn")
	var new_explosion = EXPLOSION.instantiate()
	new_explosion.damage += explosion_damage
	new_explosion.global_position = global_position
	new_explosion.scale = explosion_scale
	#new_explosion.collision_layer = collision_layer
	#new_explosion.collision_mask = collision_mask
	call_deferred("add_sibling", new_explosion)
