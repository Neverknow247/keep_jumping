extends Interactable_script

func _ready():
	if stats["save_data"]["level_data"]["level_1"]["_normal_reunions"] > 0:
		unlocked = true
		$Sprite2D/dog_sprite.show()
