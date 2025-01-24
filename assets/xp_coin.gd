extends Area2D
class_name DropItem

@export var experience : int

signal experience_gain

func _ready() -> void:
	$AnimatedSprite2D.play("idle")
	body_entered.connect(_on_body_entered)
	
func _on_body_entered(body: Node2D) -> void:
	if body.has_method("on_experience_gain"):
		body.on_experience_gain(experience)
		print("Player gained " + str(experience) + " XP")
		queue_free()
