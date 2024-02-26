extends ColorRect

var stats = Stats
var global_timer = GlobalTimer

const ScoreItem = preload("res://addons/silent_wolf/Scores/ScoreItem.tscn")

var no_badge_art = preload("res://assets/art/ui/no_badge.png")
var bronze_badge_art = preload("res://assets/art/ui/bronze_badge.png")
var silver_badge_art = preload("res://assets/art/ui/silver_badge.png")
var gold_badge_art = preload("res://assets/art/ui/gold_badge.png")
var diamond_badge_art = preload("res://assets/art/ui/diamond_badge.png")

@onready var mode_label = $VBoxContainer/mode_label

@onready var badge = $VBoxContainer/time_box/badge
@onready var new_time = $VBoxContainer/time_box/new_time
@onready var new_best_time = $VBoxContainer/time_box/new_best_time

@onready var best_time_badge = $main/main_content/scores_and_xp/score/best_time_section/best_time_badge
@onready var best_time_label = $main/main_content/scores_and_xp/score/best_time_section/time/best_time_label
@onready var label = $main/main_content/scores_and_xp/score/best_time_section/time/label

@onready var diamond_time_label = $main/main_content/scores_and_xp/pawprints/diamond/diamond_time_label
@onready var gold_time_label = $main/main_content/scores_and_xp/pawprints/gold/gold_time_label
@onready var silver_time_label = $main/main_content/scores_and_xp/pawprints/silver/silver_time_label
@onready var bronze_time_label = $main/main_content/scores_and_xp/pawprints/bronze/bronze_time_label

@onready var score_container = $main/main_content/leaderboard/ScrollContainer/score_container

@onready var volume_menu = $volume_menu

@onready var transition = $transition

var level_id_board
var level_id
var mode_name

var list_index = 0
var max_scores = stats.LEADERBOARD_MAX_SCORES

var time = GlobalTimer.time
var record_time
var new_best

func _ready():
	GlobalSteam.connect("received_results",_on_received_results)
	clear_leaderboard()
	set_mode()
	Steam.findLeaderboard(level_id_board)
	await get_tree().create_timer(1).timeout
	update_score()
	await get_tree().create_timer(4).timeout
	update_times()
	unlock_mode()
	SaveAndLoad.update_save_data()
	GlobalSteam.download_leaderboard()
	#await get_tree().create_timer(2).timeout
	#load_scores()

func set_mode():
#	Speed Run Modes
	if stats.mode == "dog_dash":
		level_id_board = "dog_dash"
		level_id = "dog_dash"
		mode_name = "Dog Dash"
	elif stats.mode == "ninja_dash":
		level_id_board = "ninja_dash"
		level_id = "ninja_dash"
		mode_name = "Ninja Dash"
#	Iron Modes
	elif stats.mode == "iron_dog":
		level_id_board = "iron_dog"
		level_id = "iron_dog"
		mode_name = "Iron Dog"
	elif stats.mode == "iron_ninja":
		level_id_board = "iron_ninja"
		level_id = "iron_ninja"
		mode_name = "Iron Ninja"

func unlock_mode():
	if level_id == "dog_dash" && !stats.save_data["iron_dog_mode"]:
		stats.save_data["iron_dog_mode"] = true
		stats.save_data["level_data"]["dog_dash"]["egg"]=true
	elif level_id == "ninja_dash" && !stats.save_data["iron_ninja_mode"]:
		stats.save_data["iron_ninja_mode"] = true
		stats.save_data["level_data"]["ninja_dash"]["egg"]=true
	elif level_id == "iron_dog" && !stats.save_data["level_data"]["iron_dog"]["egg"]:
		stats.save_data["level_data"]["iron_dog"]["egg"]=true
	elif level_id == "iron_ninja" && !stats.save_data["level_data"]["iron_ninja"]["egg"]:
		stats.save_data["level_data"]["iron_ninja"]["egg"]=true

func clear_leaderboard() -> void:
	if score_container.get_child_count() > 0:
		var children = score_container.get_children()
		for c in children:
			score_container.remove_child(c)
			c.queue_free()

func update_score():
	var modified_time = time*1000
	Steam.uploadLeaderboardScore(modified_time)
	if time < stats.save_data[level_id_board]:
		new_best = true
		stats.save_data[level_id_board] = time
	else:
		new_best = false
	record_time = stats.save_data[level_id_board]

func update_times():
	clear_leaderboard()
	update_badge_times()
	update_badge_icons()
	mode_label.text = mode_name
	new_time.text = global_timer.time_passed
	var mils = fmod(record_time, 1)*1000
	var secs = fmod(record_time,60)
	var mins = fmod(record_time, 60*60)/60
	var hours = fmod(fmod(record_time, 3600*60)/3600,24)
	best_time_label.text = "%02d:%02d:%02d:%03d" % [hours,mins,secs,mils]
	if new_best:
		pass
	else:
		new_best_time.text = ""

func update_badge_times():
	bronze_time_label.text = "%02d:%02d:%02d:%03d" % [fmod(fmod(stats["medal_times"][level_id]["bronze"], 3600*60)/3600,24),fmod(stats["medal_times"][level_id]["bronze"], 60*60)/60, fmod(stats["medal_times"][level_id]["bronze"],60), fmod(stats["medal_times"][level_id]["bronze"], 1)*1000]
	silver_time_label.text = "%02d:%02d:%02d:%03d" % [fmod(fmod(stats["medal_times"][level_id]["silver"], 3600*60)/3600,24),fmod(stats["medal_times"][level_id]["silver"], 60*60)/60, fmod(stats["medal_times"][level_id]["silver"],60), fmod(stats["medal_times"][level_id]["silver"], 1)*1000]
	gold_time_label.text = "%02d:%02d:%02d:%03d" % [fmod(fmod(stats["medal_times"][level_id]["gold"], 3600*60)/3600,24),fmod(stats["medal_times"][level_id]["gold"], 60*60)/60, fmod(stats["medal_times"][level_id]["gold"],60), fmod(stats["medal_times"][level_id]["gold"], 1)*1000]
	diamond_time_label.text = "%02d:%02d:%02d:%03d" % [fmod(fmod(stats["medal_times"][level_id]["diamond"], 3600*60)/3600,24),fmod(stats["medal_times"][level_id]["diamond"], 60*60)/60, fmod(stats["medal_times"][level_id]["diamond"],60), fmod(stats["medal_times"][level_id]["diamond"], 1)*1000]

func update_badge_icons():
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

func _on_received_results(result):
	for i in result:
		var unmodified_score = float(i.score)/1000
		print(unmodified_score)
		add_item(Steam.getFriendPersonaName(i.steam_id),("%02d:%02d:%03d" % [fmod(unmodified_score, 60*60)/60, fmod(unmodified_score,60), fmod(unmodified_score, 1)*1000]))
		print(i.global_rank)
		print(Steam.getFriendPersonaName(i.steam_id))
		print(i.score)

func load_scores():
	var sw_result = await SilentWolf.Scores.get_scores(0, level_id).sw_get_scores_complete
	var scores = sw_result.scores
	print(scores)
	render_board(scores)

func render_board(scores):
	for score in scores:
		add_item(score.player_name, ("%02d:%02d:%02d:%03d" % [fmod(fmod(score.score*-1, 3600*60)/3600,24),fmod(score.score*-1, 60*60)/60, fmod(score.score*-1,60), fmod(score.score*-1, 1)*1000]))

func add_item(player_name: String, score_value: String):
	if list_index >= max_scores:
		return
	var item = ScoreItem.instantiate()
	list_index += 1
	item.get_node("PlayerName").text = str(list_index) + str(". ") + player_name
	item.get_node("Score").text = score_value
	item.offset_top = list_index * 100
	if player_name == SilentWolf.Auth.logged_in_player:
		item.get_node("PlayerName").add_theme_color_override("font_color",Color("#66cdaa"))
	score_container.add_child(item)

func _on_restart_run_button_pressed():
	@warning_ignore("narrowing_conversion")
	Sounds.play_sfx("click",randf_range(.8,1.2),-10)
	global_timer.timer_on = false
	global_timer.time = 0
	transition.fade_out()
	await get_tree().create_timer(stats.transition_time).timeout
	get_tree().change_scene_to_file("res://levels/levels_1/level_1_1.tscn")

func _on_main_menu_button_pressed():
	@warning_ignore("narrowing_conversion")
	Sounds.play_sfx("click",randf_range(.8,1.2),-10)
	transition.fade_out()
	await get_tree().create_timer(stats.transition_time).timeout
	get_tree().change_scene_to_file("res://menus/main_menu.tscn")

func _on_credits_button_pressed():
	@warning_ignore("narrowing_conversion")
	Sounds.play_sfx("click",randf_range(.8,1.2),-10)
	transition.fade_out()
	await get_tree().create_timer(stats.transition_time).timeout
	get_tree().change_scene_to_file("res://menus/credits.tscn")
