extends Camera2D

@onready var timer = $Timer

var shake = 0

func _ready():
	Events.add_screenshake.connect(_add_screen_shake)

@warning_ignore("unused_parameter")
func _process(delta):
	offset.x = randf_range(-shake,shake)
	offset.y = randf_range(-shake,shake)

func _add_screen_shake(amount,duration):
	if Utils.screen_shake:
		shake = amount
		timer.start(duration)

func _on_timer_timeout():
	shake = 0
