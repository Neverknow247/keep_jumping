extends Area2D

signal start_timer
var started = false

func _on_body_exited(body):
	if body.is_in_group("player") and !started:
		started = true
		start_timer.emit()



func _on_body_entered(body):
	if body.is_in_group("player") and !started:
		started = true
		start_timer.emit()
