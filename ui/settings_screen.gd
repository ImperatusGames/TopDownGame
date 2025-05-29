extends CanvasLayer

@onready var game = get_node("/root/Game")
@onready var wep_sfx_volume_slider = %SFXSlider
@onready var music_volume_slider = %MusicSlider

func _ready() -> void:
	#%Save.pressed.connect(save_settings)
	%Exit.pressed.connect(exit_settings)
	%MuteSFXCheckBox.pressed.connect(mute_SFX)
	# Initialize sliders with current bus volumes
	wep_sfx_volume_slider.value = db_to_linear(AudioManager.get_wep_sfx_volume())
	music_volume_slider.value = db_to_linear(AudioManager.get_music_volume())
	
	wep_sfx_volume_slider.value_changed.connect(_on_wep_sfx_volume_changed)
	music_volume_slider.value_changed.connect(_on_music_volume_changed)
	set_states()

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		exit_settings()
		
func _on_wep_sfx_volume_changed(value: float):
	print("SFX: ", value)
	AudioManager.set_wep_sfx_volume(value)

func _on_music_volume_changed(value: float):
	AudioManager.set_music_volume(value)

#func save_settings():
	#pass

func exit_settings():
	get_parent().visible = true
	queue_free()

func mute_SFX():
	AudioManager.set_wep_sfx_mute(!AudioManager.get_sfx_mute())

func set_states():
	#Any states that need to be checked can be put into this function and set based on their current state
	if AudioManager.get_wep_sfx_mute() == true:
		%MuteSFXCheckBox.button_pressed = true
	else:
		%MuteSFXCheckBox.button_pressed = false
