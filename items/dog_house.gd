extends Interactable_script

signal finish_pet

@onready var animation_player = $AnimationPlayer

func _ready():
	if stats.calc_total_reunions() > 0:
		unlocked = true
		$Sprite2D/dog_sprite.show()
	else:
		unlocked = false
		$Sprite2D/dog_sprite.hide()
