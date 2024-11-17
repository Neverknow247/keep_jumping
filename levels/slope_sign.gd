extends Sprite2D

var stats = Stats

@onready var label = $Label

func _ready():
	if stats["save_data"]["slopeless"]:
		label.text = "Slopes\n=\nDeath"
	elif stats["save_data"]["blind_mode"]:
		label.text = "Slopes\n=\nInvisible"
	else:
		label.text = "Slopes\n=\nSlide"
