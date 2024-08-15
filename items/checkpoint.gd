extends Area2D

var sounds = Sounds

signal activate_checkpoint(respawn_position,checkpoint)

@onready var animation_player = $AnimationPlayer
@onready var sparkle_animation = $sparkle_animation

@export var active = false
@export var slopeless = false

func _ready():
	if active:
		animation_player.play("animate")
		set_sparkle(false)

func _on_body_entered(body):
	if !active:
		set_sparkle(false)
		@warning_ignore("narrowing_conversion")
		sounds.play_sfx("bowl_bury", randf_range(0.6,1.4), -10)
		active = true
		body.checkpoint = true
		activate_checkpoint.emit(global_position,self)
		animation_player.play("animate")
		SaveAndLoad.update_save_data()

func set_sparkle(sparkle_on):
	sparkle_animation.visible = sparkle_on
	if sparkle_on:
		sparkle_animation.play("default")
	else:
		sparkle_animation.stop()
