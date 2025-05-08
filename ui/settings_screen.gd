extends CanvasLayer


@onready var game = get_node("/root/Game")

func _ready() -> void:
	%Save.pressed.connect(save_settings)
	%Exit.pressed.connect(exit_settings)
	%MuteSFXCheckBox.pressed.connect(mute_SFX)
	set_states()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		exit_settings()

func save_settings():
	pass

func exit_settings():
	get_parent().visible = true
	queue_free()

func mute_SFX():
	AudioManager.set_sfx_mute(!AudioManager.get_sfx_mute())

func set_states():
	#Any states that need to be checked can be put into this function and set based on their current state
	if AudioManager.get_sfx_mute() == true:
		%MuteSFXCheckBox.button_pressed = true
	else:
		%MuteSFXCheckBox.button_pressed = false
