extends ColorRect

var stats = Stats

signal reset_run

@onready var slopeless_button = $CenterContainer/VBoxContainer/slopeless_button
@onready var normal_button = $CenterContainer/VBoxContainer/normal_button
@onready var blind_button = $CenterContainer/VBoxContainer/blind_button

func _ready():
	if !stats["save_data"]["blind_mode_unlocked"]:
		blind_button.hide()
	#if !stats["save_data"]["slopeless"] and !stats["save_data"]["blind_mode"]:
		#normal_button.hide()
	#elif stats["save_data"]["slopeless"]:
		#slopeless_button.hide()
	#elif stats["save_data"]["blind_mode"]:
		#blind_button.hide()

func focus():
	normal_button.grab_focus()
	#if stats["save_data"]["slopeless"]:
		#normal_button.grab_focus()
	#else:
		#slopeless_button.grab_focus()

func _on_slopeless_button_pressed():
	stats["save_data"]["slopeless"] = true
	stats["save_data"]["blind_mode"] = false
	reset_run.emit()

func _on_normal_button_pressed():
	stats["save_data"]["slopeless"] = false
	stats["save_data"]["blind_mode"] = false
	reset_run.emit()

func _on_blind_button_pressed():
	stats["save_data"]["blind_mode"] = true
	stats["save_data"]["slopeless"] = false
	reset_run.emit()
