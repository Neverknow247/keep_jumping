extends Control

var stats = Stats

@onready var transition = $transition

var bonus_levels = [
	stats.level_2_9.egg
]

func _on_back_button_pressed():
	transition.fade_out()
	await get_tree().create_timer(stats.transition_time).timeout
	get_tree().change_scene_to_file("res://menus/mode_select.tscn")

func _on_original_level_button_pressed():
	transition.fade_out()
	await get_tree().create_timer(stats.transition_time).timeout
	get_tree().change_scene_to_file("res://levels/level_original/level_original.tscn")
