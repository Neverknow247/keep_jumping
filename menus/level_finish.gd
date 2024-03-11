extends ColorRect

var stats = Stats
var global_timer = GlobalTimer

const ScoreItem = preload("res://menus/scores/ScoreItem.tscn")

@onready var level_name = $VBoxContainer/level_name
@onready var demo_text = $VBoxContainer/demo_text
@onready var new_time = $VBoxContainer/time_box/new_time
@onready var score_container = $main/main_content/leaderboard/ScrollContainer/score_container

var list_index = 0
var max_scores = 100

func _ready():
	clear_leaderboard()
	GlobalSteam.connect("received_results",_on_recieved_results)
	GlobalSteam.download_leaderboard()
	new_time.text = global_timer.time_passed
	if Stats["demo"]:
		demo_text.show()
		level_name.hide()


func _on_restart_button_pressed():
	if stats["demo"]:
		get_tree().change_scene_to_file("res://levels/level_1_demo.tscn")
	else:
		get_tree().change_scene_to_file("res://levels/level_1.tscn")

func _on_quit_button_pressed():
	get_tree().quit()

func clear_leaderboard():
	if score_container.get_child_count() > 0:
		var children = score_container.get_children()
		for c in children:
			score_container.remove_child(c)
			c.queue_free()

func _on_recieved_results(result):
	for i in result:
		if list_index >= max_scores:
			return
		var unmodified_score = float(i.score)/1000
		print(unmodified_score)
		list_index+=1
		add_score_item(Steam.getFriendPersonaName(i.steam_id),("%02d:%02d:%03d" % [fmod(unmodified_score, 60*60)/60, fmod(unmodified_score,60), fmod(unmodified_score, 1)*1000]))

func add_score_item(player_name:String, score_value:String):
	var item = ScoreItem.instantiate()
	item.get_node("PlayerName").text = str(list_index)+str(". ")+player_name
	item.get_node("Score").text = score_value
	item.offset_top = list_index*100
	if player_name == GlobalSteam.logged_in_user:
		item.get_node("PlayerName").add_theme_color_override("font_color",Color("#66cdaa"))
	score_container.add_child(item)
