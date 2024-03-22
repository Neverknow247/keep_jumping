extends Interactable_script

func _ready():
	if stats["save_data"]["stats"]["Total Reunions"] > 0:
		unlocked = true
		$Sprite2D/dog_sprite.show()
