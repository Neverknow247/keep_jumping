extends StaticBody2D

var stats = Stats

@onready var sprite_2d = $Sprite2D
@onready var closed_collision = $closed_collision

func _ready():
	if stats["save_data"]["current_run_data"]["upper_bell"] and stats["save_data"]["current_run_data"]["lower_bell"]:
		closed_collision.disabled = true
		sprite_2d.frame = 1
	else:
		closed_collision.disabled = false
		sprite_2d.frame = 0

func check_bells(upper,lower):
	if upper and lower:
		closed_collision.disabled = true
		sprite_2d.frame = 1
	else:
		closed_collision.disabled = false
		sprite_2d.frame = 0
