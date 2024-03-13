extends Node

signal pop_up(type,text)

var dev_mode = false
var demo = true

var game_mode = "normal"
var blind_mode = false

var cheat_code = null
var cheats = {
	"on" : false,
	"hp" : false
}

var transition_time = .25
var ground_color = "#f5ad67"

const level_num = 1

var medal_times = {
	"level_1" : {
		"bronze" : 75.0000,
		"silver" : 67.5000,
		"gold" : 62.5000,
		"diamond" : 60.0000,
		"developer" : 45.0000,
	},
}

var new_save_data = {
	"version" : ProjectSettings.get_setting("application/config/version"),
	"tutorial_complete" : false,
	"demo_complete" : false,
	"equiped_hat" : "",
	"equiped_armor" : "",
	"stats" : {
		"Power On Count" : 0,
		"Towers Attempted" : 0,
		"Steps Taken" : 0,
		"Jumped" : 0,
		"Spring Bounced" : 0,
		"Spiked" : 0,
		"Slope Slides" : 0,
	},
	"eggs" : {
		"demo" : false,
		"santa" : false,
		"crown" : false,
		"ball_cap" : false,
	},
	"level_data":{},
}

var new_level_data = {
	"_normal_time" : 604800.0000,
	"_normal_blind_time" : 604800.0000,
	"_hard_time" : 604800.0000,
	"_hard_blind_time" : 604800.0000,
	"_normal_reunions" : 0,
	"_normal_blind_reunions" : 0,
	"_hard_reunions" : 0,
	"_hard_blind_reunions" : 0,
}

var save_data = return_new_save_data()

func return_new_save_data():
	var new_data = new_save_data.duplicate(true)
	new_data["level_data"]["level_1_demo"] = new_level_data.duplicate(true)
	for level in level_num:
		var level_name = "level_%s" % [str(level+1)]
		new_data["level_data"][level_name] = new_level_data.duplicate(true)
	new_data["level_data"]["level_1"]["unlocked"] = true
	#print_verbose(new_data)
	return new_data

func delete_save():
	save_data = return_new_save_data()

