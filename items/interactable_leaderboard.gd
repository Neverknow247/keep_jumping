extends Interactable_script

@onready var board_label = $board_label

func _ready():
	temp_check()
	if stats["save_data"]["stats"]["Total Reunions"]:
		unlocked = true
		board_label.text = "Leaderboards"

func temp_check():
	if stats["save_data"]["level_data"]["level_1_demo"]["_normal_reunions"] > stats["save_data"]["stats"]["Total Reunions"]:
		stats["save_data"]["stats"]["Total Reunions"] = stats["save_data"]["level_data"]["level_1_demo"]["_normal_reunions"]
