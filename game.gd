extends Node2D

#@onready var ice_orb_button = preload("res://orb_spawn.gd")
@onready var player = get_node("/root/Game/Player")
#@onready var ice_button = $IceOrbSpawn.get_node("Button")
#@onready var fire_button = $FireOrbSpawn.get_node("Button")
#@onready var bolt_button = $BoltOrbSpawn.get_node("Button")
@onready var pause_screen = preload("res://ui/pause_screen.tscn")
@onready var level_up_screen = preload("res://ui/level_up_screen.tscn")
@onready var game_over_screen = preload("res://ui/game_over.tscn")
@onready var starting_popup = preload("res://ui/starting_popup.tscn")

@onready var game_ui: CanvasLayer = $GameUI
var game_time: float = 0.0
var score: int = 0

func _ready() -> void:
	#ice_button.pressed.connect(_ice_orb_spawn_pressed)
	#fire_button.pressed.connect(_fire_orb_spawn_pressed)
	#bolt_button.pressed.connect(_bolt_orb_spawn_pressed)
	player.connect("level_up_signal", level_up)
	player.connect("health_depleted", player_dead)
	call_deferred("start_game")
	%Timer.timeout.connect(_on_timer_timeout)
	
func _process(delta: float) -> void:
	game_time += delta
	game_ui.set_timer(game_time)
	if randf() < 0.1 * delta:  # Random score increase for testing
		score += 10
		game_ui.set_score(score)
	
	if Input.is_action_just_pressed("ui_cancel"):
		show_pause_screen()
	
func ice_orb_pressed():
	const ICE_ORB = preload("res://player/weapons/ice_orb.tscn")
	var new_orb = ICE_ORB.instantiate()
	#new_orb.global_position = player.global_position
	#new_orb.global_rotation = player.global_rotation
	player.add_weapon_orb(new_orb)
	#print("Ice Orb button press done")
	#print("New Ice Orb spawned at " + str(new_orb.global_position))
	
func fire_orb_pressed():
	const FIRE_ORB = preload("res://player/weapons/fire_orb.tscn")
	var new_orb = FIRE_ORB.instantiate()
	#new_orb.global_position = player.global_position
	#new_orb.global_rotation = player.global_rotation
	player.add_weapon_orb(new_orb)
	#print("Fire Orb button press done")
	#print("New Fire Orb spawned at " + str(new_orb.global_position))

func bolt_orb_pressed():
	const BOLT_ORB = preload("res://player/weapons/lightning_orb.tscn")
	var new_orb = BOLT_ORB.instantiate()
	#new_orb.global_position = player.global_position
	#new_orb.global_rotation = player.global_rotation
	player.add_weapon_orb(new_orb)
	#print("Bolt Orb button press done")
	#print("New Bolt Orb spawned at " + str(new_orb.global_position))

func show_pause_screen():
	var show_pause = pause_screen.instantiate()
	add_child(show_pause)
	get_tree().paused = true
	show_pause.visible = true

func close_pause_screen():
	get_tree().paused = false
	
func end_game():
	get_tree().change_scene_to_file("res://ui/title_screen.tscn")
	#call_deferred("queue_free")

func level_up():
	var show_level_up = level_up_screen.instantiate()
	add_child(show_level_up)
	get_tree().paused = true

func player_dead():
	var game_over = game_over_screen.instantiate()
	add_child(game_over)
	get_tree().paused = true

func start_game():
	var startup = starting_popup.instantiate()
	add_child(startup)
	get_tree().paused = true
	%ZombieSpawner.start_timer()

func _on_timer_timeout():
	if %TitanSpawner.is_active() == false:
		%TitanSpawner.start_timer(3.0)
		print("Titans spawning!")
		AudioManager.play_music("res://audio/music/Salamander Main.wav")
		%Timer.wait_time -= 15.0
	elif %FleaSpawner.is_active() == false:
		%FleaSpawner.start_timer(4.0)
		print("Fleas spawning!")
		AudioManager.play_music("res://audio/music/Fantasy Vol5 Dragon Dance Main.wav")
	elif %MageSpawner.is_active() == false:
		%MageSpawner.start_timer(2.5)
		print("Mages spawning!")
		AudioManager.play_music("res://audio/music/Ethereal Stairway Main.wav")
		%Timer.wait_time -= 15.0
	else:
		%ZombieSpawner.reduce_timer(0.25)
		%TitanSpawner.reduce_timer(0.25)
		%FleaSpawner.reduce_timer(0.25)
		%MageSpawner.reduce_timer(0.25)
		print("Timers reduced!")
