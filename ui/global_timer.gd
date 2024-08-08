extends Control

var global_timer = GlobalTimer
var utils = Utils

@onready var label = $Label

func _ready():
	utils.change_speed_run_timer.connect(check_visible)
	check_visible()
	global_timer.connect("time_change", update_timer)

func check_visible():
	label.visible = utils.speed_run_timer

func update_timer(time):
	label.text = time
