extends CanvasLayer

@onready var game = get_node("/root/Game")

func _ready() -> void:
	%NewGame.pressed.connect()
	%TitleScreen.pressed.connect()

func new_game():
	pass

func title_screen():
	pass

func end_game():
	get_tree().paused = false
	call_deferred("queue_free")
	game.end_game()
	
#Need to finish connecting player health_empty/health_depleted signals to facilitate game over screen
