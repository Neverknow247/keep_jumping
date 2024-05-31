extends Control

var stats = Stats

@onready var general_button = $CenterContainer/VBoxContainer/general_button
@onready var sounds_button = $CenterContainer/VBoxContainer/sounds_button
@onready var keybindings_button = $CenterContainer/VBoxContainer/keybindings_button
@onready var tutorial_button = $CenterContainer/VBoxContainer/tutorial_button
@onready var credits_button = $CenterContainer/VBoxContainer/credits_button
@onready var general_menu = $general_menu
@onready var volume_menu = $volume_menu
@onready var keybinding_menu = $keybinding_menu
@onready var transition = $transition

var credits_scene = "res://menus/credits.tscn"
var tutorial_scene = "res://levels/tutorials/tutorial.tscn"
var active = false

signal change_scene(new_scene)
signal hide_menu(scene)

func _unhandled_input(event):
	if (event.is_action_pressed("ui_cancel")||(event is InputEventJoypadButton and event.button_index == 1)) and !volume_menu.visible and !keybinding_menu.visible and !general_menu.visible and active:
		_on_back_button_pressed()

func _on_hide_menu(scene):
	SaveAndLoad.update_settings()
	transition.fade_out()
	await get_tree().create_timer(stats.transition_time).timeout
	scene.hide()
	general_button.grab_focus()
	transition.fade_in()
	#SaveAndLoad.update_settings()

func _on_general_button_pressed():
	@warning_ignore("narrowing_conversion")
	Sounds.play_sfx("click",randf_range(.8,1.2),-10)
	transition.fade_out()
	await get_tree().create_timer(stats.transition_time).timeout
	general_menu.show()
	general_menu.active = true
	$general_menu/CenterContainer/VBoxContainer/window_mode/window_option_button.grab_focus()
	transition.fade_in()

func _on_sounds_button_pressed():
	@warning_ignore("narrowing_conversion")
	Sounds.play_sfx("click",randf_range(.8,1.2),-10)
	transition.fade_out()
	await get_tree().create_timer(stats.transition_time).timeout
	volume_menu.show()
	volume_menu.active = true
	$volume_menu/CenterContainer/VBoxContainer/master/master_slider.grab_focus()
	transition.fade_in()

func _on_keybindings_button_pressed():
	@warning_ignore("narrowing_conversion")
	Sounds.play_sfx("click",randf_range(.8,1.2),-10)
	transition.fade_out()
	await get_tree().create_timer(stats.transition_time).timeout
	keybinding_menu.show()
	keybinding_menu.active = true
	$keybinding_menu/CenterContainer/HBoxContainer/VBoxContainer/HBoxContainer3/left.grab_focus()
	transition.fade_in()

func _on_tutorial_button_pressed():
	@warning_ignore("narrowing_conversion")
	Sounds.play_sfx("click",randf_range(.8,1.2),-10)
	transition.fade_out()
	await get_tree().create_timer(stats.transition_time).timeout
	get_tree().change_scene_to_file(tutorial_scene)

func _on_credits_button_pressed():
	@warning_ignore("narrowing_conversion")
	Sounds.play_sfx("click",randf_range(.8,1.2),-10)
	transition.fade_out()
	await get_tree().create_timer(stats.transition_time).timeout
	get_tree().change_scene_to_file(credits_scene)

func _on_back_button_pressed():
	@warning_ignore("narrowing_conversion")
	Sounds.play_sfx("click",randf_range(.8,1.2),-10)
	active = false
	hide_menu.emit(self)
