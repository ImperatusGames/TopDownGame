extends CanvasLayer

@onready var settings_screen = preload("res://ui/settings_screen.tscn")
@onready var game_load = preload("res://game.tscn")

func _ready() -> void:
	%StartGame.pressed.connect(start_game)
	%Settings.pressed.connect(settings)
	%ExitGame.pressed.connect(exit_game)
	%DummySprite.play("default")

func settings():
	visible = false
	var show_settings = settings_screen.instantiate()
	add_child(show_settings)

func start_game():
	get_tree().change_scene_to_file("res://game.tscn")
	#call_deferred("queue_free")

func exit_game():
	get_tree().quit()
