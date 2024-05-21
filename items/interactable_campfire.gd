extends Interactable_script

@onready var sprite_2d = $Sprite2D

func _ready():
	if stats["save_data"]["slopeless"]:
		sprite_2d.frame = 1
	check_unlock()

func check_unlock():
	if stats["save_data"]["slopeless_unlocked"]:
		unlocked = true
