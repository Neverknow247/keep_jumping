extends StaticBody2D

@onready var animation_player = $AnimationPlayer
@onready var timer = $Timer

var monitor = true

func _on_area_2d_body_entered(body):
	if monitor:
		animation_player.play("break")
		monitor = false

func _on_timer_timeout():
	animation_player.play("RESET")
	monitor = true
