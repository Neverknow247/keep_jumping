extends ColorRect

var stats = Stats
var global_timer = GlobalTimer

const ScoreItem = preload("res://menus/scores/ScoreItem.tscn")

var list_index = 0

@onready var level_name = $VBoxContainer/level_name

@onready var resume_button = $buttons/resume_button
@onready var restart_button = $buttons/restart_button


@onready var main = $main
@onready var settings_menu = $settings_menu
@onready var transition = $transition

signal fade_out
signal resetting


var pausable = true
var mode
var lb_name

var paused = false:
	get:
		return paused
	set(value):
		paused = value
		get_tree().paused = paused
		visible = paused

var reset_unlocked = true

func _ready():
	if stats["save_data"]["stats"]["Total Reunions"] > 0:
		restart_button.show()
	visible = false

func _input(event):
	if event.is_action_pressed("pause") && paused and !settings_menu.visible:
		change_pause()
	if event.is_action_pressed("reset_level") && reset_unlocked:
		if paused:
			_on_restart_button_pressed()
	if event is InputEventMouseMotion:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func change_pause():
	self.paused = !paused
	if paused:
		resume_button.grab_focus()
	else:
		release_focus()

func pause():
	change_pause()


func _on_resume_button_pressed():
	@warning_ignore("narrowing_conversion")
	Sounds.play_sfx("click",randf_range(.8,1.2),-10)
	change_pause()

func _on_restart_button_pressed():
	@warning_ignore("narrowing_conversion")
	Sounds.play_sfx("click",randf_range(.8,1.2),-10)
	emit_signal("resetting")
	emit_signal("fade_out")
	await get_tree().create_timer(stats.transition_time).timeout
	change_pause()
	get_tree().reload_current_scene()

func _on_main_menu_button_pressed():
	@warning_ignore("narrowing_conversion")
	Sounds.play_sfx("click",randf_range(.8,1.2),-10)
	emit_signal("resetting")
	emit_signal("fade_out")
	await get_tree().create_timer(stats.transition_time).timeout
	change_pause()
	get_tree().change_scene_to_file("res://menus/main_menu.tscn")

func _on_settings_button_pressed():
	@warning_ignore("narrowing_conversion")
	Sounds.play_sfx("click",randf_range(.8,1.2),-10)
	transition.fade_out()
	await get_tree().create_timer(stats.transition_time).timeout
	settings_menu.show()
	settings_menu.active = true
	$settings_menu/CenterContainer/VBoxContainer/sounds_button.grab_focus()
	transition.fade_in()

func _on_hide_menu(scene):
	print("hide")
	transition.fade_out()
	await get_tree().create_timer(stats.transition_time).timeout
	scene.hide()
	resume_button.grab_focus()
	transition.fade_in()

func _on_quit_button_pressed():
	get_tree().quit()
