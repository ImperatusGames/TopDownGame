extends CanvasLayer

#signal fire_orb_spawn
#signal ice_orb_spawn
#signal bolt_orb_spawn

@onready var game = get_node("/root/Game")

func _ready() -> void:
	%Ice.pressed.connect(_ice_orb_spawn_pressed)
	%Fire.pressed.connect(_fire_orb_spawn_pressed)
	%Lightning.pressed.connect(_bolt_orb_spawn_pressed)

func _ice_orb_spawn_pressed():
	game.ice_orb_pressed()
	close_popup()

func _fire_orb_spawn_pressed():
	game.fire_orb_pressed()
	close_popup()

func _bolt_orb_spawn_pressed():
	game.bolt_orb_pressed()
	close_popup()

func close_popup():
	get_tree().paused = false
	visible = false
	call_deferred("queue_free")
