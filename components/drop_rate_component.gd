extends Node2D

@export var drop_rate : float
@export var drop_item : PackedScene
@export var experience : int

func drop_attempt():
	if drop_item == null:
		print("No drop item available")
		return

	var drop_chance = randf() * 100
	print(drop_chance, "% drop chance")
	if drop_chance <= drop_rate:
		var new_xp_coin = drop_item.instantiate()
		new_xp_coin.global_position = get_parent().global_position
		new_xp_coin.experience = experience
		get_parent().get_parent().call_deferred("add_child", new_xp_coin)
