extends Area2D

signal hit(damage)

func _on_body_entered(body):
	call_deferred("spike_tiles_hit")

func spike_tiles_hit():
	hit.emit(1)
