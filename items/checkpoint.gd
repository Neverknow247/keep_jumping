extends Area2D

signal activate_checkpoint(respawn_position,checkpoint)

@onready var animation_player = $AnimationPlayer

@export var active = false

func _ready():
	if active:
		animation_player.play("animate")

func _on_body_entered(body):
	if !active:
		active = true
		body.checkpoint = true
		activate_checkpoint.emit(global_position,self)
		animation_player.play("animate")
		SaveAndLoad.update_save_data()
