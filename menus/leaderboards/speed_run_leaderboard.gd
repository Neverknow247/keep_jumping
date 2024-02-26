@tool
extends Control

var stats = Stats

const ScoreItem = preload("res://addons/silent_wolf/Scores/ScoreItem.tscn")
const SWLogger = preload("res://addons/silent_wolf/utils/SWLogger.gd")

@onready var mode_label = $Board/TitleContainer/mode_label
@onready var score_item_container = $Board/HighScores/ScrollContainer/ScoreItemContainer

@onready var transition = $transition

var list_index = 0

# Replace the leaderboard name if you're not using the default leaderboard
var ld_name = stats.mode

var max_scores = stats.LEADERBOARD_MAX_SCORES


func _ready():
	GlobalSteam.connect("received_results",_on_received_results)
	clear_leaderboard()
	set_label()
	load_scores()

func set_label():
	if ld_name == "dog_dash":
		mode_label.text = "Dog Dash"
	elif ld_name == "ninja_dash":
		mode_label.text = "Ninja Dash"
	elif ld_name == "iron_dog":
		mode_label.text = "Iron Dog"
	elif ld_name == "iron_ninja":
		mode_label.text = "Iron Ninja"

func load_scores():
	Steam.findLeaderboard(ld_name)
	await get_tree().create_timer(1).timeout
	GlobalSteam.download_leaderboard()
	#transition.fade_in()
#	print("SilentWolf.Scores.leaderboards: " + str(SilentWolf.Scores.leaderboards))
#	print("SilentWolf.Scores.ldboard_config: " + str(SilentWolf.Scores.ldboard_config))
	#var scores = SilentWolf.Scores.scores
	##var scores = []
	#if ld_name in SilentWolf.Scores.leaderboards:
		#scores = SilentWolf.Scores.leaderboards[ld_name]
	#var local_scores = SilentWolf.Scores.local_scores
	#
	#if false:
		#pass
##	if len(scores) > 0: 
##		render_board(scores, local_scores)
	#else:
		## use a signal to notify when the high scores have been returned, and show a "loading" animation until it's the case...
		#add_loading_scores_message()
		#var sw_result = await SilentWolf.Scores.get_scores(0, ld_name).sw_get_scores_complete
		#scores = sw_result.scores
		#hide_message()
		#render_board(scores, local_scores)

func _on_received_results(result):
	for i in result:
		var unmodified_score = float(i.score)/1000
		print(unmodified_score)
		add_item(Steam.getFriendPersonaName(i.steam_id),("%02d:%02d:%03d" % [fmod(unmodified_score, 60*60)/60, fmod(unmodified_score,60), fmod(unmodified_score, 1)*1000]))
		print(i.global_rank)
		print(Steam.getFriendPersonaName(i.steam_id))
		print(i.score)
	#set_tabs_disable()

func render_board(scores: Array, local_scores: Array) -> void:
	var all_scores = scores
	if ld_name in SilentWolf.Scores.ldboard_config and is_default_leaderboard(SilentWolf.Scores.ldboard_config[ld_name]):
		all_scores = merge_scores_with_local_scores(scores, local_scores)
		if scores.is_empty() and local_scores.is_empty():
			add_no_scores_message()
	else:
		if scores.is_empty():
			add_no_scores_message()
	if all_scores.is_empty():
		for score in scores:
			add_item(score.player_name, str((score.score)*-1))
			add_item(score.player_name, ("%02d:%02d:%02d:%03d" % [fmod(fmod(score.score*-1, 3600*60)/3600,24),fmod(score.score*-1, 60*60)/60, fmod(score.score*-1,60), fmod(score.score*-1, 1)*1000]))
	else:
		for score in all_scores:
			add_item(score.player_name, ("%02d:%02d:%02d:%03d" % [fmod(fmod(score.score*-1, 3600*60)/3600,24),fmod(score.score*-1, 60*60)/60, fmod(score.score*-1,60), fmod(score.score*-1, 1)*1000]))
#			add_item(score.player_name, str((score.score)*-1))


func is_default_leaderboard(ld_config: Dictionary) -> bool:
	var default_insert_opt = (ld_config.insert_opt == "keep")
	var not_time_based = !("time_based" in ld_config)
	return default_insert_opt and not_time_based

func merge_scores_with_local_scores(scores: Array[Dictionary], local_scores: Array[Dictionary]) -> Array[Dictionary]:
	if local_scores:
		for score in local_scores:
			var in_array = score_in_score_array(scores, score)
			if !in_array:
				scores.append(score)
			scores.sort_custom(sort_by_score);
	var return_scores = scores
	if scores.size() > max_scores:
		return_scores = scores.resize(max_scores)
	return return_scores

func sort_by_score(a: Dictionary, b: Dictionary) -> bool:
	if a.score > b.score:
		return true;
	else:
		if a.score < b.score:
			return false;
		else:
			return true;

func score_in_score_array(scores: Array[Dictionary], new_score: Dictionary) -> bool:
	var in_score_array =  false
	if !new_score.is_empty() and !scores.is_empty():
		for score in scores:
			if score.score_id == new_score.score_id: # score.player_name == new_score.player_name and score.score == new_score.score:
				in_score_array = true
	return in_score_array

func add_item(player_name: String, score_value: String) -> void:
	if list_index >= max_scores:
		return
	var item = ScoreItem.instantiate()
	list_index += 1
	item.get_node("PlayerName").text = str(list_index) + str(". ") + player_name
	item.get_node("Score").text = score_value
	item.offset_top = list_index * 100
	if player_name == SilentWolf.Auth.logged_in_player:
		item.get_node("PlayerName").add_theme_color_override("font_color",Color("#66cdaa"))
	score_item_container.add_child(item)

func add_no_scores_message() -> void:
	var item = $"Board/MessageContainer/TextMessage"
	item.text = "No scores yet!"
	$"Board/MessageContainer".show()
#	item.margin_top = 135

func add_loading_scores_message() -> void:
	var item = $"Board/MessageContainer/TextMessage"
	item.text = "Loading scores..."
	$"Board/MessageContainer".show()
#	item.margin_top = 135

func hide_message() -> void:
	$"Board/MessageContainer".hide()

func clear_leaderboard() -> void:
	if score_item_container.get_child_count() > 0:
		var children = score_item_container.get_children()
		for c in children:
			score_item_container.remove_child(c)
			c.queue_free()

func _on_back_button_pressed():
	@warning_ignore("narrowing_conversion")
	Sounds.play_sfx("click",randf_range(.8,1.2),-10)
	transition.fade_out()
	await get_tree().create_timer(stats.transition_time).timeout
	get_tree().change_scene_to_file("res://menus/speed_run_select.tscn")
