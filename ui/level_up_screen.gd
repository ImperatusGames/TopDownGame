extends CanvasLayer

@onready var player = get_node("/root/Game/Player")
var weapon_type = null
var weapon_upgrade = null

func _ready() -> void:
	%DamageUp.pressed.connect(damage_up)
	%SpecialUp.pressed.connect(weapon_special)
	%HealthUp.pressed.connect(health_up)
	%SpeedUp.pressed.connect(speed_up)
	weapon_type = player.get_weapon_type()
	#var weapon_level = player.get_weapon_level()
	special_button_display()

func speed_up():
	player.speed_increase(0.10)
	cleanup()

func health_up():
	player.health_increase(20)
	cleanup()

func damage_up():
	player.damage_increase(1)
	cleanup()

func weapon_special():
	match weapon_upgrade:
		"add":
			var game = get_node("/root/Game")
			game.fire_orb_pressed()
		"explosions":
			player.enable_explosions()
		"explosion_size":
			player.explosion_size()
		"slow":
			player.enable_slow()
		"pierce":
			player.enable_pierce()
		"pierce_increase":
			player.pierce_increase()
		"freeze":
			player.enable_freeze()
		"status_rate_up":
			player.status_rate_up()
		"chain_lightning":
			player.enable_chain_lightning()
		"chain_rate":
			player.chain_rate_up()
	cleanup()

func special_button_display():
	if weapon_type == "FireOrb":
		var count = player.get_weapon_size()
		var states = player.get_fire_states()
		if count < 4:
			%SpecialUp.text = "Add Fire Orb"
			set_upgrade("add")
		elif states[0] == false:
			%SpecialUp.text = "Enable Explosions"
			set_upgrade("explosions")
		elif count < 8:
			%SpecialUp.text = "Add Fire Orb"
			set_upgrade("add")
		else:
			%SpecialUp.text = "Increase Explosion Size"
			set_upgrade("explosion_size")
	elif weapon_type == "IceOrb":
		var states = player.get_ice_states()
		if states[0] == false:
			%SpecialUp.text = "Chance to Slow on Hit"
			set_upgrade("slow")
		elif states[1] == false:
			%SpecialUp.text = "Shot Pierces 1 enemy"
			set_upgrade("pierce")
		elif states[2] < 2:
			%SpecialUp.text = "Increase the Number of Pierces by 1"
			set_upgrade("pierce_increase")
		elif states[3] == false:
			%SpecialUp.text = "Chance to Freeze on Hit"
			set_upgrade("freeze")
		elif states[2] <= 4:
			%SpecialUp.text = "Increase the Number of Pierces by 1"
			set_upgrade("pierce_increase")
		else:
			%SpecialUp.text = "Increase Slow and Freeze Chance"
			set_upgrade("status_rate_up")
	elif weapon_type == "LightningOrb":
		var states = player.get_lightning_states()
		if states[0] == false:
			%SpecialUp.text = "Enable Chain Lightning"
			set_upgrade("chain_lightning")
		else:
			%SpecialUp.text = "Increase Chain Lightning Rate"
			set_upgrade("chain_rate")
	else:
		%SpecialUp.text = "You Shouldn't See This!"

func set_upgrade(upgrade):
	weapon_upgrade = upgrade

func cleanup():
	get_tree().paused = false
	call_deferred("queue_free")
