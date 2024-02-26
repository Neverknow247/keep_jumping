extends ColorRect

var stats = Stats
const ScoreItem = preload("res://menus/scores/ScoreItem.tscn")

var no_badge_art = preload("res://assets/art/ui/no_badge.png")
var bronze_badge_art = preload("res://assets/art/ui/bronze_badge.png")
var silver_badge_art = preload("res://assets/art/ui/silver_badge.png")
var gold_badge_art = preload("res://assets/art/ui/gold_badge.png")
var diamond_badge_art = preload("res://assets/art/ui/diamond_badge.png")

var list_index = -1

var last = false
var ghost = false
var lb_name

@onready var level_name = $VBoxContainer/level_name
@onready var badge = $VBoxContainer/time_box/badge
@onready var new_time = $VBoxContainer/time_box/new_time
@onready var new_best_time = $VBoxContainer/time_box/new_best_time
@onready var best_time_badge = $main/main_content/scores_and_xp/score/best_time_section/best_time_badge
@onready var best_time_label = $main/main_content/scores_and_xp/score/best_time_section/time/best_time_label
@onready var bronze_time_label = $main/main_content/scores_and_xp/pawprints/bronze/bronze_time_label
@onready var silver_time_label = $main/main_content/scores_and_xp/pawprints/silver/silver_time_label
@onready var gold_time_label = $main/main_content/scores_and_xp/pawprints/gold/gold_time_label
@onready var diamond_time_label = $main/main_content/scores_and_xp/pawprints/diamond/diamond_time_label
@onready var score_container = $main/main_content/leaderboard/ScrollContainer/score_container
@onready var leaderboard_label = $main/main_content/leaderboard/leaderboard_label

@onready var restart_button = $buttons/restart_button
@onready var level_select_button = $buttons/level_select_button
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
	GlobalSteam.connect("received_results",_on_received_results)
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

func clear_leaderboard() -> void:
	list_index = 0
	if score_container.get_child_count() > 0:
		var children = score_container.get_children()
		for c in children:
			score_container.remove_child(c)
			c.queue_free()

func update_times(time, record_time, _level_name, level_id, new_best):
	clear_leaderboard()
	update_badge_times(level_id)
	update_badge_icons(time, record_time, level_id)
	new_time.text = "%02d:%02d:%03d" % [fmod(time, 60*60)/60, fmod(time,60), fmod(time, 1)*1000]
	best_time_label.text = "%02d:%02d:%03d" % [fmod(record_time, 60*60)/60, fmod(record_time,60), fmod(record_time, 1)*1000]
	level_name.text = _level_name
	if new_best:
		pass
	else:
		new_best_time.text = ""

func update_badge_times(level_id):
	bronze_time_label.text = "%02d:%02d:%03d" % [fmod(stats["medal_times"][level_id]["bronze"], 60*60)/60, fmod(stats["medal_times"][level_id]["bronze"],60), fmod(stats["medal_times"][level_id]["bronze"], 1)*1000]
	silver_time_label.text = "%02d:%02d:%03d" % [fmod(stats["medal_times"][level_id]["silver"], 60*60)/60, fmod(stats["medal_times"][level_id]["silver"],60), fmod(stats["medal_times"][level_id]["silver"], 1)*1000]
	gold_time_label.text = "%02d:%02d:%03d" % [fmod(stats["medal_times"][level_id]["gold"], 60*60)/60, fmod(stats["medal_times"][level_id]["gold"],60), fmod(stats["medal_times"][level_id]["gold"], 1)*1000]
	diamond_time_label.text = "%02d:%02d:%03d" % [fmod(stats["medal_times"][level_id]["diamond"], 60*60)/60, fmod(stats["medal_times"][level_id]["diamond"],60), fmod(stats["medal_times"][level_id]["diamond"], 1)*1000]

func update_badge_icons(time, record_time, level_id):
	if time <= stats["medal_times"][level_id]["diamond"]:
		badge.texture = diamond_badge_art
	elif time <= stats["medal_times"][level_id]["gold"]:
		badge.texture = gold_badge_art
	elif time <= stats["medal_times"][level_id]["silver"]:
		badge.texture = silver_badge_art
	elif time <= stats["medal_times"][level_id]["bronze"]:
		badge.texture = bronze_badge_art
	
	if record_time <= stats["medal_times"][level_id]["diamond"]:
		best_time_badge.texture = diamond_badge_art
	elif record_time <= stats["medal_times"][level_id]["gold"]:
		best_time_badge.texture = gold_badge_art
	elif record_time <= stats["medal_times"][level_id]["silver"]:
		best_time_badge.texture = silver_badge_art
	elif record_time <= stats["medal_times"][level_id]["bronze"]:
		best_time_badge.texture = bronze_badge_art

func load_scores(level_id):
	lb_name = level_id
	Steam.findLeaderboard(level_id)
	await get_tree().create_timer(4).timeout
	GlobalSteam.download_leaderboard()

func _on_received_results(result):
	for i in result:
		var unmodified_score = float(i.score)/1000
		print(unmodified_score)
		add_item(Steam.getFriendPersonaName(i.steam_id),("%02d:%02d:%03d" % [fmod(unmodified_score, 60*60)/60, fmod(unmodified_score,60), fmod(unmodified_score, 1)*1000]),lb_name)
		print(i.global_rank)
		print(Steam.getFriendPersonaName(i.steam_id))
		print(i.score)

func add_item(player_name: String, score_value: String, level_id):
	if list_index >= 100:
		return
	var item = ScoreItem.instantiate()
	list_index += 1
	item.get_node("PlayerName").text = str(list_index) + str(". ") + player_name
	item.get_node("Score").text = score_value
	item.offset_top = list_index * 100
	if player_name == GlobalSteam.loggin_user:
		item.get_node("PlayerName").add_theme_color_override("font_color",Color("#66cdaa"))
	score_container.add_child(item)

func first_time_last_level():
	restart_button.visible = false
	level_select_button.visible = false
	main_menu_button.visible = false

func set_world_and_level():
	if stats.level_menu_button == 9:
		return
	stats.level_menu_button += 1
	if stats.level_menu_button == 9:
		stats.level_menu_button = 0
		stats.world_menu_select += 1

func _on_next_level_button_pressed():
	@warning_ignore("narrowing_conversion")
	Sounds.play_sfx("click",randf_range(.8,1.2),-10)
	set_world_and_level()
	emit_signal("fade_out")
	await get_tree().create_timer(stats.transition_time).timeout
	change_pause()
	emit_signal("next_level")

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
