extends ColorRect

var stats = Stats

const ScoreItem = preload("res://menus/scores/ScoreItem.tscn")

@onready var scroll_container = $CenterContainer/VBoxContainer/ScrollContainer
@onready var score_container = $CenterContainer/VBoxContainer/ScrollContainer/score_container

var list_index = 0
var max_scores = 10000

func _ready():
	GlobalSteam.connect("leaderboard_found",set_up_leaderboard)
	GlobalSteam.connect("received_results",_on_recieved_results)

var scroll = 0
var scroll_item_size = 54
var scroll_step = scroll_item_size * 6
func _input(event):
	if visible and event.is_action_pressed("controller_down"):
		scroll=min(scroll+scroll_step,(score_container.get_child_count()*54)-540)
		scroll_container.set_deferred("scroll_vertical",scroll)
	if visible and event.is_action_pressed("controller_up"):
		scroll=max(scroll-scroll_step,0)
		scroll_container.set_deferred("scroll_vertical",scroll)


func set_up_leaderboard(result):
	if result == true:
		clear_leaderboard()
		GlobalSteam.download_leaderboard()
	else:
		pass

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
		#print(unmodified_score)
		list_index+=1
		add_score_item(Steam.getFriendPersonaName(i.steam_id),("%02d:%02d:%02d:%03d" % [fmod(fmod(unmodified_score, 3600*60)/3600,24),fmod(unmodified_score, 60*60)/60, fmod(unmodified_score,60), fmod(unmodified_score, 1)*1000]))

func add_score_item(player_name:String, score_value:String):
	var item = ScoreItem.instantiate()
	item.get_node("PlayerName").text = str(list_index)+str(". ")+player_name
	item.get_node("Score").text = score_value
	#item.offset_top = list_index*100
	if player_name == GlobalSteam.logged_in_user:
		item.get_node("PlayerName").add_theme_color_override("font_color",Color("#66cdaa"))
	score_container.add_child(item)
