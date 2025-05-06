extends CanvasLayer


@onready var game = get_node("/root/Game")

func _ready() -> void:
	%Save.pressed.connect(save_settings)
	%Exit.pressed.connect(exit_settings)
	%MuteSFXCheckBox.pressed.connect(mute_SFX)

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
