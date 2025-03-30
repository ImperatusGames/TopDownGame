extends CanvasLayer

@onready var health_bar: TextureProgressBar = $TopBar/HBoxContainer/LeftSection/HealthBar
@onready var xp_bar: TextureProgressBar = $TopBar/HBoxContainer/LeftSection/XPBar
@onready var score_label: Label = $TopBar/HBoxContainer/RightSection/ScoreLabel
@onready var timer_label: Label = $TopBar/HBoxContainer/RightSection/TimerLabel
@onready var level_label: Label = $TopBar/HBoxContainer/RightSection/LevelLabel
var player = null


func _ready():
	# Find player and connect signals
	player = get_node("/root/Game/Player")#get_tree().get_first_node_in_group("Player")
	if player:
		##player.health.connect("health_changed", _on_player_health_changed)
		player.health_component.connect("health_changed", _on_player_health_changed)
		player.connect("health_depleted", _on_player_health_depleted)
		player.connect("xp_changed", _on_player_xp_changed)
		xp_bar.value = player.player_xp
		xp_bar.max_value = player.xp_to_level
		health_bar.max_value = player.health_component.max_health
		health_bar.value = player.health_component.current_health
	
	# Connect to Global upgrades
	#Global.connect("upgrade_applied", _on_upgrade_applied)
	
	# Initialize UI elements
	score_label.text = "Score: 0"
	timer_label.text = "Time: 00:00"
	level_label.text = "Level 1"

func _on_player_health_changed(new_health):
	health_bar.value = new_health #player.health_component.current_health

func _on_player_health_depleted():
	# Optional: Show game over screen
	
	pass

func _on_upgrade_applied(upgrade_name: String):
	# For now, we'll just update a label; add animation if needed
	level_label.text = "Level Up! " + upgrade_name
	await get_tree().create_timer(2.0).timeout  # Simple delay
	level_label.text = "Level 1"  # Reset (replace with actual level logic)

func _on_player_xp_changed():
	xp_bar.value = player.player_xp
	xp_bar.max_value = player.xp_to_level

func set_score(score: int):
	score_label.text = "Score: " + str(score)
	print("Score = " +str(score))

func set_timer(time: float):
	var minutes = int(time / 60)
	var seconds = int(time) % 60
	timer_label.text = "Time: %02d:%02d" % [minutes, seconds]
