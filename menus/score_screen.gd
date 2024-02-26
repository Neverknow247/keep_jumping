extends Control

var stats = Stats

var level_1_1 = {
	"time": "%02d : %02d : %03d"%[fmod(stats.level_1_1["time"], 60*60)/60, fmod(stats.level_1_1["time"],60), fmod(stats.level_1_1["time"], 1)*1000]
}
var level_1_2 = {
	"time": "%02d : %02d : %03d"%[fmod(stats.level_1_2["time"], 60*60)/60, fmod(stats.level_1_2["time"],60), fmod(stats.level_1_2["time"], 1)*1000]
}
var level_1_3 = {
	"time": "%02d : %02d : %03d"%[fmod(stats.level_1_3["time"], 60*60)/60, fmod(stats.level_1_3["time"],60), fmod(stats.level_1_3["time"], 1)*1000]
}
var level_1_4 = {
	"time": "%02d : %02d : %03d"%[fmod(stats.level_1_4["time"], 60*60)/60, fmod(stats.level_1_4["time"],60), fmod(stats.level_1_4["time"], 1)*1000]
}
var level_1_5 = {
	"time": "%02d : %02d : %03d"%[fmod(stats.level_1_5["time"], 60*60)/60, fmod(stats.level_1_5["time"],60), fmod(stats.level_1_5["time"], 1)*1000]
}
var level_1_6 = {
	"time": "%02d : %02d : %03d"%[fmod(stats.level_1_6["time"], 60*60)/60, fmod(stats.level_1_6["time"],60), fmod(stats.level_1_6["time"], 1)*1000]
}
var level_1_7 = {
	"time": "%02d : %02d : %03d"%[fmod(stats.level_1_7["time"], 60*60)/60, fmod(stats.level_1_7["time"],60), fmod(stats.level_1_7["time"], 1)*1000]
}
var level_1_8 = {
	"time": "%02d : %02d : %03d"%[fmod(stats.level_1_8["time"], 60*60)/60, fmod(stats.level_1_8["time"],60), fmod(stats.level_1_8["time"], 1)*1000]
}

var level_2_1 = {
	"time": "%02d : %02d : %03d"%[fmod(stats.level_2_1["time"], 60*60)/60, fmod(stats.level_2_1["time"],60), fmod(stats.level_2_1["time"], 1)*1000]
}
var level_2_2 = {
	"time": "%02d : %02d : %03d"%[fmod(stats.level_2_2["time"], 60*60)/60, fmod(stats.level_2_2["time"],60), fmod(stats.level_2_2["time"], 1)*1000]
}
var level_2_3 = {
	"time": "%02d : %02d : %03d"%[fmod(stats.level_2_3["time"], 60*60)/60, fmod(stats.level_2_3["time"],60), fmod(stats.level_2_3["time"], 1)*1000]
}
var level_2_4 = {
	"time": "%02d : %02d : %03d"%[fmod(stats.level_2_4["time"], 60*60)/60, fmod(stats.level_2_4["time"],60), fmod(stats.level_2_4["time"], 1)*1000]
}

var level_3_1 = {
	"time": "%02d : %02d : %03d"%[fmod(stats.level_3_1["time"], 60*60)/60, fmod(stats.level_3_1["time"],60), fmod(stats.level_3_1["time"], 1)*1000]
}

var level_original = {
	"time": "%02d : %02d : %03d"%[fmod(stats.level_original["time"], 60*60)/60, fmod(stats.level_original["time"],60), fmod(stats.level_original["time"], 1)*1000]
}

@onready var label = $CenterContainer/ScrollContainer/HBoxContainer/label
@onready var times = $CenterContainer/ScrollContainer/HBoxContainer/times

func _ready():
	label.text = "Level 1-1
				\nLevel 1-2
				\nLevel 1-3
				\nLevel 1-4
				\nLevel 1-5
				\nLevel 1-6
				\nLevel 1-7
				\nLevel 1-8
				\nLevel 2-1
				\nLevel 2-2
				\nLevel 2-3
				\nLevel 2-4
				\nLevel 3-1
				\nOriginal Level"

	times.text = "%s
				\n%s
				\n%s
				\n%s
				\n%s
				\n%s
				\n%s
				\n%s
				\n%s
				\n%s
				\n%s
				\n%s
				\n%s
				\n%s" % \
				[
					level_1_1["time"],
					level_1_2["time"],
					level_1_3["time"],
					level_1_4["time"],
					level_1_5["time"],
					level_1_6["time"],
					level_1_7["time"],
					level_1_8["time"],
					level_2_1["time"],
					level_2_2["time"],
					level_2_3["time"],
					level_2_4["time"],
					level_3_1["time"],
					level_original["time"]
				]

func _on_button_pressed():
	get_tree().change_scene_to_file("res://menus/main_menu.tscn")
