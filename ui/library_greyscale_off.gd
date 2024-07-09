extends ColorRect

var stats = Stats

func _ready():
	if stats["save_data"]["equiped_armor"] == "grey":
		hide()
	else:
		show()
