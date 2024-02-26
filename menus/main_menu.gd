extends Control

var stats = Stats
var sounds = Sounds

@onready var settings_menu = $settings_menu
@onready var start_button = $CenterContainer/HBoxContainer/VBoxContainer/start_button
@onready var transition = $transition


func _ready():
	sounds.play_music("dog_house")
	start_button.grab_focus()

func _on_start_button_pressed():
	@warning_ignore("narrowing_conversion")
	Sounds.play_sfx("click",randf_range(.8,1.2),-10)
	transition.fade_out()
	await get_tree().create_timer(stats.transition_time).timeout
	get_tree().change_scene_to_file("res://levels/level_1.tscn")

func _on_settings_button_pressed():
	@warning_ignore("narrowing_conversion")
	Sounds.play_sfx("click",randf_range(.8,1.2),-10)
	transition.fade_out()
	await get_tree().create_timer(stats.transition_time).timeout
	settings_menu.show()
	settings_menu.active = true
	$settings_menu/CenterContainer/VBoxContainer/sounds_button.grab_focus()
	transition.fade_in()

func _on_quit_button_pressed():
	@warning_ignore("narrowing_conversion")
	Sounds.play_sfx("click",randf_range(.8,1.2),-10)
	transition.fade_out()
	await get_tree().create_timer(stats.transition_time).timeout
	get_tree().quit()

func _on_hide_menu(scene):
	transition.fade_out()
	await get_tree().create_timer(stats.transition_time).timeout
	scene.hide()
	start_button.grab_focus()
	transition.fade_in()
