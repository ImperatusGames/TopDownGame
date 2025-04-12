extends VBoxContainer

signal spawn_bolt_orb

func _ready() -> void:
	%Button.pressed.connect(_button_pressed)
	
func _button_pressed():
	spawn_bolt_orb.emit()
