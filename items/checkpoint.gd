extends Area2D

signal activate_checkpoint(respawn_position)

@onready var animation_player = $AnimationPlayer

var active = false

func _on_body_entered(body):
	if !active:
		active = true
		activate_checkpoint.emit(global_position)
		animation_player.play("animate")
