extends Interactable_script

@export var location:String = "res://levels/level_1.tscn"

func _ready():
	check_unlock()

func check_unlock():
	if stats["save_data"]["items"]["fireplace"]:
		unlocked = true
	if !unlocked:
		$AnimatedSprite2D.hide()
		$AnimatedSprite2D2.hide()
		$Sprite2D.hide()
