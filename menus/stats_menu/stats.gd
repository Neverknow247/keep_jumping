extends ColorRect

var stats = Stats

const StatsHeader = preload("res://menus/stats_menu/StatsHeader.tscn")
const StatsItem = preload("res://menus/stats_menu/StatsItem.tscn")

@onready var scroll_container = $CenterContainer/VBoxContainer/ScrollContainer
@onready var stats_container = $CenterContainer/VBoxContainer/ScrollContainer/stats_container

func _ready():
	refresh_stats()

var scroll = 0
var scroll_item_size = 54
var scroll_step = scroll_item_size * 6
func _input(event):
	if visible and event.is_action_pressed("controller_down"):
		scroll=min(scroll+scroll_step,(scroll_container.get_child_count()*54))
		scroll_container.set_deferred("scroll_vertical",scroll)
	if visible and event.is_action_pressed("controller_up"):
		scroll=max(scroll-scroll_step,0)
		scroll_container.set_deferred("scroll_vertical",scroll)

func refresh_stats():
	clear_stats()
	set_stats()

func clear_stats():
	if stats_container.get_child_count() > 0:
		var children = stats_container.get_children()
		for c in children:
			stats_container.remove_child(c)
			c.queue_free()

func set_stats():
	var total_reunions = stats.calc_total_reunions()
	add_stats_header("General Stats")
	add_stats_item("Power On Count",stats["save_data"]["stats"]["Power On Count"])
	add_stats_item("Number Of Attempts",stats["save_data"]["stats"]["Towers Attempted"])
	add_stats_item("Total Reunions",total_reunions)
	add_stats_item("Steps Taken",stats["save_data"]["stats"]["Steps Taken"])
	add_stats_item("Times Jumped",stats["save_data"]["stats"]["Jumped"])
	add_stats_item("Times Spring Bounced",stats["save_data"]["stats"]["Spring Bounced"])
	add_stats_item("Times Died To Spikes",stats["save_data"]["stats"]["Spiked"])
	add_stats_item("Times On Slopes",stats["save_data"]["stats"]["Slope Slides"])
	#add_stats_header("Demo Castle")
	#add_stats_item("Normal Reunions",stats["save_data"]["level_data"]["level_1_demo"]["_normal_reunions"])

func add_stats_header(header:String):
	var item = StatsHeader.instantiate()
	item.get_node("Header").text = header
	stats_container.add_child(item)

func add_stats_item(stat:String, amount:int):
	var item = StatsItem.instantiate()
	item.get_node("Stat").text = stat
	item.get_node("Amount").text = str(amount)
	stats_container.add_child(item)
