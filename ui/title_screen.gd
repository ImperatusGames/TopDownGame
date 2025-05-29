extends CanvasLayer

@onready var settings_screen = preload("res://ui/settings_screen.tscn")
@onready var game_load = preload("res://game.tscn")
@onready var credits_screen = preload("res://ui/credits.tscn")

func _ready() -> void:
	%StartGame.pressed.connect(start_game)
	%Settings.pressed.connect(settings)
	%ExitGame.pressed.connect(exit_game)
	%Credits.pressed.connect(credits)
	%DummySprite.play("default")
	AudioManager.play_music("res://audio/music/Ethereal Epiphone Main.wav")

func settings():
	visible = false
	var show_settings = settings_screen.instantiate()
	add_child(show_settings)

func start_game():
	get_tree().change_scene_to_file("res://game.tscn")
	#call_deferred("queue_free")

func exit_game():
	get_tree().quit()

func credits():
	var credits = credits_screen.instantiate()
	add_child(credits)
