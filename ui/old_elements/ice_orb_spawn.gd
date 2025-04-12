extends VBoxContainer

signal spawn_ice_orb

func _ready() -> void:
	%Button.pressed.connect(_button_pressed)
	
func _button_pressed():
	spawn_ice_orb.emit()
