extends ColorRect

@onready var resume_button = $CenterContainer/VBoxContainer/resume_button

var pausable = true

var paused = false:
	get:
		return paused
	set(value):
		paused = value
		get_tree().paused = paused
		visible = paused

func _ready():
	visible = false

func _process(delta):
	if Input.is_action_just_pressed("pause") && pausable:
		change_pause()

func change_pause():
	self.paused = !paused
	if paused:
		resume_button.grab_focus()
	else:
		release_focus()

func _on_resume_button_pressed():
	change_pause()

func _on_restart_button_pressed():
	change_pause()
	get_tree().reload_current_scene()

func _on_main_menu_button_pressed():
	change_pause()
	get_tree().change_scene_to_file("res://menus/main_menu.tscn")

func _on_quit_button_pressed():
	get_tree().quit()
