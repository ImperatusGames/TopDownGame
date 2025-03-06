#extends Node2D
class_name FreezeStatusEffect extends StatusEffect

func _ready() -> void:
	$Timer.timeout.connect(_on_freeze_timeout)
	#get_tree().call_group("Status Effects", "slowed")
	get_parent().get_node("VelocityComponent").frozen()

func _on_freeze_timeout():
	#get_tree().call_group("Status Effects", "restore_speed")
	get_parent().get_node("VelocityComponent").restore_speed()
	call_deferred("queue_free")

func _freeze_timer_refresh():
	%Timer.start(1.5)

####Rewrite functionality as follows
# Check if enemy is already slowed status effect instance
# If not, instantiate slow
# If it does, restart slow timer
####
