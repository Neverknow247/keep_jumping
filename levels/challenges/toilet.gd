extends Area2D

var stats = Stats

signal unlock_toilet

func _on_body_entered(body):
	if !stats["save_data"]["items"]["toilet"]:
		unlock_toilet.emit()
