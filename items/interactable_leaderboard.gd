extends Interactable_script

@onready var board_label = $board_label

func _ready():
	if stats["save_data"]["level_data"]["level_1_demo"]["_normal_reunions"] > 0:
		unlocked = true
		board_label.text = "Leaderboards"

