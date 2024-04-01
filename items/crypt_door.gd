extends StaticBody2D

var stats = Stats

@export var disabled = false

@onready var sprite_2d = $Sprite2D
@onready var closed_collision = $closed_collision

func _ready():
	if stats.calc_total_reunions() > 0 || disabled:
		closed_collision.disabled = true
		sprite_2d.frame = 1
	else:
		closed_collision.disabled = false
		sprite_2d.frame = 0
