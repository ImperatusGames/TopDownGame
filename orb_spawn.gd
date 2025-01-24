extends VBoxContainer

@onready var ice_orb = preload("res://player/weapons/ice_orb.tscn")
@onready var player = preload("res://player/player.tscn")

func _ready() -> void:
	%Button.pressed.connect(_button_pressed)
	
func _button_pressed():
	ice_orb.instantiate()
	ice_orb.global_position = player.global_position
	ice_orb.add_to_group("Player")
	
