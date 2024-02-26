extends StaticBody2D

signal level_complete(next_level)

@export var next_level: String

@warning_ignore("unused_parameter")
func _on_area_2d_body_entered(body):
	emit_signal("level_complete", next_level)
