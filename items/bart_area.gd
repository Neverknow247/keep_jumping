extends Interactable_script

var sounds = Sounds

func _ready():
	check_unlocked()

func setup():
	if unlocked:
		$Sprite2D.frame = 1
		@warning_ignore("narrowing_conversion")
		sounds.play_sfx("pickup", randf_range(0.6,1.4), -10)
		stats["save_data"]["armors"]["bart"] = true
		SaveAndLoad.update_save_data()
		unlocked = false

func check_unlocked():
	if stats["save_data"]["items"]["cape"] and stats["save_data"]["items"]["belt"] and stats["save_data"]["items"]["cape"] and !stats["save_data"]["armors"]["bart"]:
		unlocked = true
	if stats["save_data"]["armors"]["bart"]:
		$Sprite2D.frame = 1
		unlocked = false
