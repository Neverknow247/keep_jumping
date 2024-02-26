extends ColorRect

var stats = Stats
var global_timer = GlobalTimer

const ScoreItem = preload("res://menus/scores/ScoreItem.tscn")

var no_badge_art = preload("res://assets/art/ui/no_badge.png")
var bronze_badge_art = preload("res://assets/art/ui/bronze_badge.png")
var silver_badge_art = preload("res://assets/art/ui/silver_badge.png")
var gold_badge_art = preload("res://assets/art/ui/gold_badge.png")
var diamond_badge_art = preload("res://assets/art/ui/diamond_badge.png")

var list_index = 0

@onready var level_name = $VBoxContainer/level_name

@onready var best_time_badge = $main/main_content/scores_and_xp/score/best_time_section/best_time_badge
@onready var best_time_label = $main/main_content/scores_and_xp/score/best_time_section/time/best_time_label

@onready var bronze_time_label = $main/main_content/scores_and_xp/pawprints/bronze/bronze_time_label
@onready var silver_time_label = $main/main_content/scores_and_xp/pawprints/silver/silver_time_label
@onready var gold_time_label = $main/main_content/scores_and_xp/pawprints/gold/gold_time_label
@onready var diamond_time_label = $main/main_content/scores_and_xp/pawprints/diamond/diamond_time_label

@onready var score_container = $main/main_content/leaderboard/ScrollContainer/score_container
@onready var leaderboard_label = $main/main_content/leaderboard/leaderboard_label

@onready var resume_button = $buttons/resume_button
@onready var restart_button = $buttons/restart_button
@onready var level_select_button = $buttons/level_select_button


@onready var main = $main
@onready var settings_menu = $settings_menu
@onready var transition = $transition

signal next_level
signal reset_bury_bone
signal fade_out
signal resetting

var ghost = false

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
	GlobalSteam.connect("received_results",_on_received_results)
	visible = false

func set_up_leaderboards(record_time, _level_name, level_id, level_id_board):
	clear_leaderboard()
	if mode == "upside_down":
		rotation = 180
		return
	if mode != "dog_walker" && mode != "ninja_dog":
		#_level_name = mode
		level_id = mode
		level_id_board = mode
		record_time = stats.save_data[level_id]
	list_index = 0
	lb_name = level_id_board
	update_times(record_time, _level_name, level_id)
	Steam.findLeaderboard(level_id_board)
	await get_tree().create_timer(4).timeout
	clear_leaderboard()
	GlobalSteam.download_leaderboard()
	#load_scores(level_id_board)

func _input(event):
	if event.is_action_pressed("pause") && paused and !settings_menu.visible:
		change_pause()
	if event.is_action_pressed("reset_level") && reset_unlocked:
		if paused:
			_on_restart_button_pressed()


func change_pause():
	self.paused = !paused
	if paused:
		restart_button.grab_focus()
	else:
		release_focus()

func pause():
	change_pause()

func clear_leaderboard() -> void:
	list_index = 0
	if score_container.get_child_count() > 0:
		var children = score_container.get_children()
		for c in children:
			score_container.remove_child(c)
			c.queue_free()

func update_times(record_time, _level_name, level_id):
	update_badge_times(level_id)
	update_badge_icons(record_time, level_id)
	best_time_label.text = "%02d:%02d:%03d" % [fmod(record_time, 60*60)/60, fmod(record_time,60), fmod(record_time, 1)*1000]
	level_name.text = _level_name

func update_badge_times(level_id):
	bronze_time_label.text = "%02d:%02d:%03d" % [fmod(stats["medal_times"][level_id]["bronze"], 60*60)/60, fmod(stats["medal_times"][level_id]["bronze"],60), fmod(stats["medal_times"][level_id]["bronze"], 1)*1000]
	silver_time_label.text = "%02d:%02d:%03d" % [fmod(stats["medal_times"][level_id]["silver"], 60*60)/60, fmod(stats["medal_times"][level_id]["silver"],60), fmod(stats["medal_times"][level_id]["silver"], 1)*1000]
	gold_time_label.text = "%02d:%02d:%03d" % [fmod(stats["medal_times"][level_id]["gold"], 60*60)/60, fmod(stats["medal_times"][level_id]["gold"],60), fmod(stats["medal_times"][level_id]["gold"], 1)*1000]
	diamond_time_label.text = "%02d:%02d:%03d" % [fmod(stats["medal_times"][level_id]["diamond"], 60*60)/60, fmod(stats["medal_times"][level_id]["diamond"],60), fmod(stats["medal_times"][level_id]["diamond"], 1)*1000]

func update_badge_icons(record_time, level_id):
	if record_time <= stats["medal_times"][level_id]["diamond"]:
		best_time_badge.texture = diamond_badge_art
	elif record_time <= stats["medal_times"][level_id]["gold"]:
		best_time_badge.texture = gold_badge_art
	elif record_time <= stats["medal_times"][level_id]["silver"]:
		best_time_badge.texture = silver_badge_art
	elif record_time <= stats["medal_times"][level_id]["bronze"]:
		best_time_badge.texture = bronze_badge_art

func _on_received_results(result):
	for i in result:
		var unmodified_score = float(i.score)/1000
		add_ghost_item(Steam.getFriendPersonaName(i.steam_id),("%02d:%02d:%03d" % [fmod(unmodified_score, 60*60)/60, fmod(unmodified_score,60), fmod(unmodified_score, 1)*1000]),lb_name)

func add_ghost_item(player_name: String, score_value: String, level_id):
	if list_index >= 1000:
		return
	var item = ScoreItem.instantiate()
	list_index += 1
	item.get_node("PlayerName").text = str(list_index) + str(". ") + player_name
	item.get_node("Score").text = score_value
	item.offset_top = list_index * 100
	if player_name == GlobalSteam.loggin_user:
		item.get_node("PlayerName").add_theme_color_override("font_color",Color("#66cdaa"))
	score_container.add_child(item)


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

func _on_reset_bury_bone_button_pressed():
	@warning_ignore("narrowing_conversion")
	Sounds.play_sfx("click",randf_range(.8,1.2),-10)
	change_pause()
	emit_signal("reset_bury_bone")

func _on_next_level_button_pressed():
	@warning_ignore("narrowing_conversion")
	Sounds.play_sfx("click",randf_range(.8,1.2),-10)
	change_pause()
	emit_signal("next_level")

func _on_level_select_button_pressed():
	@warning_ignore("narrowing_conversion")
	Sounds.play_sfx("click",randf_range(.8,1.2),-10)
	emit_signal("resetting")
	emit_signal("fade_out")
	await get_tree().create_timer(stats.transition_time).timeout
	change_pause()
	get_tree().change_scene_to_file(stats.worlds[stats.world_menu_select])

func _on_restart_run_button_pressed():
	@warning_ignore("narrowing_conversion")
	Sounds.play_sfx("click",randf_range(.8,1.2),-10)
	emit_signal("resetting")
	emit_signal("fade_out")
	await get_tree().create_timer(stats.transition_time).timeout
	change_pause()
	global_timer.timer_on = false
	global_timer.time = 0
	get_tree().change_scene_to_file("res://levels/levels_1/level_1_1.tscn")

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
	resume_button.grab_focus()
	transition.fade_in()
