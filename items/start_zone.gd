extends Area2D

var steam = GlobalSteam

signal start_timer
var started = false

func _on_body_exited(body):
	if body.is_in_group("player") and !started:
		started = true
		start_timer.emit()

func _on_body_entered(body):
	steam["level_id_board"] = steam["main_level_id"]
	Steam.findLeaderboard(steam["level_id_board"])
	if body.is_in_group("player") and !started:
		started = true
		start_timer.emit()
