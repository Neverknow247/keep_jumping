extends Area2D

@onready var animated_sprite_2d = $AnimatedSprite2D

func _ready():
	randomize_frame()

func randomize_frame():
	var rand = randi_range(0,7)
	animated_sprite_2d.frame = rand

func _on_body_entered(body):
	body.in_sand = true
	body.state = "sand_state_enter"

func _on_body_exited(body):
	body.in_sand = false
	body.state = "move_state"
