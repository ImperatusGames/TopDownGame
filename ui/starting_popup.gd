extends CanvasLayer

signal fire_orb_spawn
signal ice_orb_spawn
signal bolt_orb_spawn

func _ready() -> void:
	$%Ice.pressed.connect(_ice_orb_spawn_pressed)
	$Fire.pressed.connect(_fire_orb_spawn_pressed)
	$Lightning.pressed.connect(_bolt_orb_spawn_pressed)

func _ice_orb_spawn_pressed():
	ice_orb_spawn.emit()

func _fire_orb_spawn_pressed():
	fire_orb_spawn.emit()

func _bolt_orb_spawn_pressed():
	bolt_orb_spawn.emit()
