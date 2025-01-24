extends Area2D

var travelled_distance = 0
var damage = 1

func _ready() -> void:
	area_entered.connect(_on_area_entered)

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
		print("Damage dealt!")
		queue_free()
