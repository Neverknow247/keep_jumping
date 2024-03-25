extends Control

var stats = Stats
var utils = Utils

signal hide_menu(scene)

@onready var colorblind_mode_check = $CenterContainer/VBoxContainer/colorblind_mode/colorblind_mode_check
@onready var back_button = $back_button

var active = false

func _ready():
	colorblind_mode_check.button_pressed = utils.color_blind_mode

func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel") and active:
		_on_back_button_pressed()

func _on_colorblind_mode_check_toggled(toggled_on):
	utils.color_blind_mode = toggled_on

func _on_back_button_pressed():
	@warning_ignore("narrowing_conversion")
	Sounds.play_sfx("click",randf_range(.8,1.2),-10)
	SaveAndLoad.update_settings()
	active = false
	hide_menu.emit(self)


