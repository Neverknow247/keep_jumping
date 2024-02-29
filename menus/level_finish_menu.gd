extends ColorRect

var stats = Stats
const ScoreItem = preload("res://menus/scores/ScoreItem.tscn")


@onready var restart_button = $buttons/restart_button
@onready var main_menu_button = $buttons/main_menu_button
@onready var settings_menu = $settings_menu
@onready var transition = $transition


signal next_level
signal fade_out

var paused = false:
	get:
		return paused
	set(value):
		paused = value
		get_tree().paused = paused
		visible = paused

func _ready():
	visible = false
	

func _input(event):
	if event.is_action_pressed("reset_level"):
		if paused:
			await get_tree().create_timer(stats.transition_time).timeout
			change_pause()
			get_tree().reload_current_scene()

func change_pause():
	self.paused = !paused
	if paused:
		restart_button.grab_focus()
	else:
		release_focus()



func _on_restart_button_pressed():
	@warning_ignore("narrowing_conversion")
	Sounds.play_sfx("click",randf_range(.8,1.2),-10)
	emit_signal("fade_out")
	await get_tree().create_timer(stats.transition_time).timeout
	change_pause()
	get_tree().reload_current_scene()

func _on_main_menu_button_pressed():
	@warning_ignore("narrowing_conversion")
	Sounds.play_sfx("click",randf_range(.8,1.2),-10)
	emit_signal("fade_out")
	await get_tree().create_timer(stats.transition_time).timeout
	change_pause()
	get_tree().change_scene_to_file("res://menus/main_menu.tscn")

func _on_level_select_button_pressed():
	@warning_ignore("narrowing_conversion")
	Sounds.play_sfx("click",randf_range(.8,1.2),-10)
	emit_signal("fade_out")
	await get_tree().create_timer(stats.transition_time).timeout
	change_pause()
	get_tree().change_scene_to_file(stats.worlds[stats.world_menu_select])

func _on_credits_button_pressed():
	@warning_ignore("narrowing_conversion")
	Sounds.play_sfx("click",randf_range(.8,1.2),-10)
	emit_signal("fade_out")
	await get_tree().create_timer(stats.transition_time).timeout
	change_pause()
	get_tree().change_scene_to_file("res://menus/credits.tscn")

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
	transition.fade_out()
	await get_tree().create_timer(stats.transition_time).timeout
	scene.hide()
	transition.fade_in()
