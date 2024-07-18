extends StaticBody2D

@onready var sprite_2d = $Sprite2D
@onready var closed_collision = $closed_collision

var door_opened = false

func _ready():
	close_door()

func close_door():
	closed_collision.disabled = false
	sprite_2d.frame = 0

func open_door():
	if !door_opened:
		@warning_ignore("narrowing_conversion")
		Sounds.play_sfx("enemy_die",randf_range(0.8,1.4),-10)
		closed_collision.disabled = true
		sprite_2d.frame = 1
		door_opened = true
