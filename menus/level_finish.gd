extends ColorRect


var global_timer = GlobalTimer

@onready var new_time = $VBoxContainer/time_box/new_time

func _ready():
	new_time.text = global_timer.time_passed
