extends Control

var stats = Stats
var utils = Utils

signal hide_menu(scene)

@onready var window_option_button = $CenterContainer/VBoxContainer/window_mode/window_option_button
@onready var colorblind_mode_check = $CenterContainer/VBoxContainer/colorblind_mode/colorblind_mode_check
@onready var wall_frame_buffer_check = $CenterContainer/VBoxContainer/wall_frame_buffer/wall_frame_buffer_check
@onready var squash_and_stretch_check = $CenterContainer/VBoxContainer/squash_and_stretch/squash_and_stretch_check
@onready var screen_shake_check = $CenterContainer/VBoxContainer/screen_shake/screen_shake_check
@onready var speed_run_timer_check = $CenterContainer/VBoxContainer/speed_run_timer/speed_run_timer_check
@onready var enable_quick_reset_check = $CenterContainer/VBoxContainer/enable_quick_reset/enable_quick_reset_check
@onready var back_button = $back_button

var active = false

func _ready():
	window_option_button.selected = utils.window_mode
	colorblind_mode_check.button_pressed = utils.color_blind_mode
	wall_frame_buffer_check.button_pressed = utils.wall_frame_buffer
	squash_and_stretch_check.button_pressed = utils.squash_and_stretch
	screen_shake_check.button_pressed = utils.screen_shake
	enable_quick_reset_check.button_pressed = utils.quick_reset
	speed_run_timer_check.button_pressed = utils.speed_run_timer

func _input(event):
	if (event.is_action_pressed("pause")||(event is InputEventJoypadButton and event.button_index == 1)) and active:
		_on_back_button_pressed()

func _on_window_option_button_item_selected(index):
	utils.window_mode = index

func _on_colorblind_mode_check_toggled(toggled_on):
	utils.color_blind_mode = toggled_on

func _on_wall_frame_buffer_check_toggled(toggled_on):
	utils.wall_frame_buffer = toggled_on

func _on_squash_and_stretch_check_toggled(toggled_on):
	utils.squash_and_stretch = toggled_on

func _on_screen_shake_check_toggled(toggled_on):
	utils.screen_shake = toggled_on

func _on_back_button_pressed():
	@warning_ignore("narrowing_conversion")
	Sounds.play_sfx("click",randf_range(.8,1.2),-10)
	#SaveAndLoad.update_settings()
	active = false
	hide_menu.emit(self)

func _on_speed_run_timer_check_toggled(toggled_on):
	utils.speed_run_timer = toggled_on

func _on_enable_quick_reset_check_toggled(toggled_on):
	utils.quick_reset = toggled_on
