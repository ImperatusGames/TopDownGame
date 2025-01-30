extends Node2D

#@onready var ice_orb_button = preload("res://orb_spawn.gd")
@onready var player = get_node("/root/Game/Player")
@onready var ice_button = $OrbSpawn.get_node("Button")

func _ready() -> void:
	ice_button.pressed.connect(_ice_orb_spawn_pressed)

func _ice_orb_spawn_pressed():
	const ICE_ORB = preload("res://player/weapons/ice_orb.tscn")
	var new_orb = ICE_ORB.instantiate()
	#new_orb.global_position = player.global_position
	#new_orb.global_rotation = player.global_rotation
	player.add_child(new_orb)
	print("New Ice Orb spawned at " + str(new_orb.global_position))
