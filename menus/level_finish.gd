extends ColorRect

var stats = Stats
var global_timer = GlobalTimer

@onready var level_name = $VBoxContainer/level_name
@onready var demo_text = $VBoxContainer/demo_text

@onready var new_time = $VBoxContainer/time_box/new_time

func _ready():
	new_time.text = global_timer.time_passed
	if Stats["demo"]:
		demo_text.show()
		level_name.hide()


func _on_restart_button_pressed():
	if stats["demo"]:
		get_tree().change_scene_to_file("res://levels/level_1_demo.tscn")
	else:
		get_tree().change_scene_to_file("res://levels/level_1.tscn")

func _on_quit_button_pressed():
	get_tree().quit()
