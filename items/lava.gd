extends Node2D

@onready var particles = $particles

func _on_visible_on_screen_notifier_2d_screen_entered():
	particles.emitting = true

func _on_visible_on_screen_notifier_2d_screen_exited():
	particles.emitting = false
