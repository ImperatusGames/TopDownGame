extends Node

@onready var music_player = AudioStreamPlayer.new()
@onready var weapon_sfx_player = AudioStreamPlayer.new()
@onready var sfx_player = AudioStreamPlayer.new()
@onready var footstep_player = AudioStreamPlayer.new()

var is_sfx_muted: bool = false

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

func play_music(path: String):
	var music = load(path) as AudioStream
	music_player.stream = music
	music_player.play()

func play_weapon_sfx(path: String, pitch_variation: float = 0.0):
	if is_sfx_muted:
		return # Skip playing if muted
	var weapon_sfx = load(path) as AudioStream
	weapon_sfx_player.stream = weapon_sfx
	if pitch_variation > 0:
		weapon_sfx_player.pitch_scale = randf_range(1.0 - pitch_variation, 1.0 + pitch_variation)
	weapon_sfx_player.play()
	
func play_sfx(path: String, pitch_variation: float = 0.0):
	var sfx = load(path) as AudioStream
	sfx_player.stream = sfx
	if pitch_variation > 0:
		sfx_player.pitch_scale = randf_range(1.0 - pitch_variation, 1.0 + pitch_variation)
	sfx_player.play()
	
func play_footstep():
	footstep_player.play()

func stop_music():
	music_player.stop()

# Mute or unmute sound effects
func set_sfx_mute(muted: bool):
	is_sfx_muted = muted
	AudioServer.set_bus_mute(AudioServer.get_bus_index("WEP_SFX"), muted)

# Get current SFX mute state
func get_sfx_mute() -> bool:
	return is_sfx_muted
