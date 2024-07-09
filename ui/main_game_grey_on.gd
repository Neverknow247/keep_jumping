extends ColorRect

var stats = Stats

func _ready():
	check_grey()
	stats.changed_sprite.connect(check_grey)

func check_grey():
	if stats["save_data"]["equiped_armor"] == "grey":
		show()
	else:
		hide()
