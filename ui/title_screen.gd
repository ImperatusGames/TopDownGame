extends CanvasLayer

@onready var settings_screen = preload("res://ui/settings_screen.tscn")
@onready var game_load = preload("res://game.tscn")

func _ready() -> void:
	%StartGame.pressed.connect(start_game)
	%Settings.pressed.connect(settings)
	%ExitGame.pressed.connect(exit_game)
	%DummySprite.animation = "default"

func settings():
	visible = false
	var show_settings = settings_screen.instantiate()
	add_child(show_settings)

func start_game():
	var new_game = game_load.instantiate()
	add_sibling(new_game)
	call_deferred("queue_free")

func exit_game():
	get_tree().quit()
