extends CanvasLayer

@onready var game = get_node("/root/Game")
@onready var settings_screen = preload("res://ui/settings_screen.tscn")

func _ready() -> void:
	%Resume.pressed.connect(end_pause)
	%Settings.pressed.connect(settings)
	%EndRun.pressed.connect(end_game)

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel") and visible == true:
		end_pause()

func end_pause():
	game.close_pause_screen()
	queue_free()

func settings():
	visible = false
	var show_settings = settings_screen.instantiate()
	add_child(show_settings)
	
func end_game():
	get_tree().paused = false
	call_deferred("queue_free")
	game.end_game()
	
