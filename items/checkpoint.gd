extends Area2D

signal activate_checkpoint(respawn_position)

@onready var animation_player = $AnimationPlayer

@export var active = false

func _ready():
	if active:
		activate_checkpoint.emit(global_position)
		animation_player.play("animate")

func _on_body_entered(body):
	if !active:
		active = true
		activate_checkpoint.emit(global_position)
		animation_player.play("animate")
