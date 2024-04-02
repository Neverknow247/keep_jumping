extends Interactable_script

var sounds = Sounds

func _ready():
	check_unlocked()

func setup():
	if unlocked:
		$Sprite2D.show()
		GlobalSteam.setAchievement("ACH_PICNIC_SETUP")
		sounds.play_sfx("pickup", randf_range(0.6,1.4), -10)
		stats["save_data"]["items"]["picnic"] = true
		SaveAndLoad.update_save_data()
		unlocked = false

func check_unlocked():
	if stats["save_data"]["items"]["towel"] and stats["save_data"]["items"]["white_rose"] and stats["save_data"]["items"]["basket"] and !stats["save_data"]["items"]["picnic"]:
		unlocked = true
	if stats["save_data"]["items"]["picnic"]:
		$Sprite2D.show()
		unlocked = false
