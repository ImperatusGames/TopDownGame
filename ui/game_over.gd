extends CanvasLayer

@onready var game = get_node("/root/Game")

func _ready() -> void:
	%NewGame.pressed.connect(new_game)
	%TitleScreen.pressed.connect(title_screen)

func new_game():
	get_tree().paused = false
	get_tree().reload_current_scene()

func title_screen():
	get_tree().paused = false
	call_deferred("queue_free")
	game.end_game()
	

#Need to finish connecting player health_empty/health_depleted signals to facilitate game over screen
