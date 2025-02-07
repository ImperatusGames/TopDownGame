extends Node2D

#@onready var ice_orb_button = preload("res://orb_spawn.gd")
@onready var player = get_node("/root/Game/Player")
@onready var ice_button = $IceOrbSpawn.get_node("Button")
@onready var fire_button = $FireOrbSpawn.get_node("Button")
@onready var bolt_button = $BoltOrbSpawn.get_node("Button")

func _ready() -> void:
	ice_button.pressed.connect(_ice_orb_spawn_pressed)
	fire_button.pressed.connect(_fire_orb_spawn_pressed)
	bolt_button.pressed.connect(_bolt_orb_spawn_pressed)
	#%Timer.timeout.connect(_on_timer_timeout)
	
func _ice_orb_spawn_pressed():
	const ICE_ORB = preload("res://player/weapons/ice_orb.tscn")
	var new_orb = ICE_ORB.instantiate()
	#new_orb.global_position = player.global_position
	#new_orb.global_rotation = player.global_rotation
	player.add_child(new_orb)
	print("New Ice Orb spawned at " + str(new_orb.global_position))
	
func _fire_orb_spawn_pressed():
	const FIRE_ORB = preload("res://player/weapons/fire_orb.tscn")
	var new_orb = FIRE_ORB.instantiate()
	#new_orb.global_position = player.global_position
	#new_orb.global_rotation = player.global_rotation
	player.add_child(new_orb)
	print("New Fire Orb spawned at " + str(new_orb.global_position))

func _bolt_orb_spawn_pressed():
	const BOLT_ORB = preload("res://player/weapons/lightning_orb.tscn")
	var new_orb = BOLT_ORB.instantiate()
	#new_orb.global_position = player.global_position
	#new_orb.global_rotation = player.global_rotation
	player.add_child(new_orb)
	print("New Bolt Orb spawned at " + str(new_orb.global_position))

#func spawn_mob():
	#var new_mob = preload("res://enemies/zombie.tscn").instantiate()
	#%PathFollow2D.progress_ratio = randf()
	#new_mob.global_position = %PathFollow2D.global_position
	#add_child(new_mob)
#
#func _on_timer_timeout():
	#spawn_mob()
