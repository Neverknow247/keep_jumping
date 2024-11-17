extends Interactable_script

@onready var sprite_2d = $Sprite2D

func _ready():
	if stats["save_data"]["slopeless"]:
		sprite_2d.frame = 1
	elif stats["save_data"]["blind_mode"]:
		sprite_2d.frame = 2
	else:
		sprite_2d.frame = 0
