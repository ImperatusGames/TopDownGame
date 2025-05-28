extends Node

@onready var music_player = AudioStreamPlayer.new()
@onready var weapon_sfx_player = AudioStreamPlayer.new()
@onready var sfx_player = AudioStreamPlayer.new()
@onready var footstep_player = AudioStreamPlayer.new()

var is_wep_sfx_muted: bool = false

enum AudioBusChannels { Master, WEP_SFX, SFX, Music}

var last_music_path: String = ""

func _ready():
	add_child(music_player)
	add_child(sfx_player)
	add_child(weapon_sfx_player)
	
	music_player.bus = "Music"
	weapon_sfx_player.bus = "WEP_SFX"
	sfx_player.bus = "SFX"
	
	add_child(footstep_player)
	footstep_player.bus = "SFX"
	footstep_player.stream = preload("res://audio/footsteps/FootstepRandomizer.tres")
	
	music_player.finished.connect(_on_music_finished)

func play_music(path: String):
	var music = load(path) as AudioStream
	music_player.stream = music
	music_player.volume_db = -14.0
	music_player.play()
	last_music_path = path
	
func _on_music_finished():
	if last_music_path != "":
		play_music(last_music_path)

func play_weapon_sfx(path: String, pitch_variation: float = 0.0):
	if is_wep_sfx_muted:
		return # Skip playing if muted
	var weapon_sfx = load(path) as AudioStream
	weapon_sfx_player.stream = weapon_sfx
	if pitch_variation > 0:
		weapon_sfx_player.pitch_scale = randf_range(1.0 - pitch_variation, 1.0 + pitch_variation)
	weapon_sfx_player.volume_db = -17.5
	weapon_sfx_player.play()
	
func play_sfx(path: String, pitch_variation: float = 0.0):
	var sfx = load(path) as AudioStream
	sfx_player.stream = sfx
	sfx_player.volume_db = -11.0
	if pitch_variation > 0:
		sfx_player.pitch_scale = randf_range(1.0 - pitch_variation, 1.0 + pitch_variation)
	sfx_player.play()
	
func play_footstep():
	footstep_player.volume_db = -2.5
	footstep_player.play()

func stop_music():
	print("stop music")
	last_music_path = ""
	music_player.stop()

# Mute or unmute sound effects
func set_wep_sfx_mute(muted: bool):
	is_wep_sfx_muted = muted
	AudioServer.set_bus_mute(AudioBusChannels.WEP_SFX, muted)

# Get current SFX mute state
func get_wep_sfx_mute() -> bool:
	return is_wep_sfx_muted

func set_wep_sfx_volume(volume_db: float):
	AudioServer.set_bus_volume_db(AudioBusChannels.WEP_SFX, linear_to_db(volume_db))
	
func get_wep_sfx_volume():
	return AudioServer.get_bus_volume_db(AudioBusChannels.WEP_SFX)
	
func set_music_volume(volume_db: float):
	AudioServer.set_bus_volume_db(AudioBusChannels.Music, linear_to_db(volume_db))
	
func get_music_volume():
	return AudioServer.get_bus_volume_db(AudioBusChannels.Music)
