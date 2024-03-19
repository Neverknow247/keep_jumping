extends Interactable_script

func _ready():
	if stats["save_data"]["stats"]["Total Reunions"]:
		unlocked = true
