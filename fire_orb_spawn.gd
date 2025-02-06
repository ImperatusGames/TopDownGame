extends VBoxContainer

signal spawn_fire_orb

func _ready() -> void:
	%Button.pressed.connect(_button_pressed)
	
func _button_pressed():
	spawn_fire_orb.emit()
