extends Area2D

var sounds = Sounds

@onready var sprite_2d = $Sprite2D

@warning_ignore("unused_parameter")
func _on_body_entered(body):
	@warning_ignore("narrowing_conversion")
	sounds.play_sfx("door_open", randf_range(0.7,1.2), -5)
	sprite_2d.frame = 1

@warning_ignore("unused_parameter")
func _on_body_exited(body):
	@warning_ignore("narrowing_conversion")
	sounds.play_sfx("door_close", randf_range(0.7,1.2), -5)
	sprite_2d.frame = 0
