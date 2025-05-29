extends CanvasLayer

func _ready():
	%Close.pressed.connect(close)

func close():
	queue_free()
