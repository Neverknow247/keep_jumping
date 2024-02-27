extends Area2D

@export var max_health = 1
@export var health = 1
@export var bounce = 200

var timer_time = 5

@onready var collision_shape_2d = $CollisionShape2D
@onready var timer = $Timer

func hit(damage):
	health -= damage
	if health <= 0:
		call_deferred("set_monitorable",false)
		hide()
		timer.start(timer_time*max_health)
		print("spawn spring")

func _on_timer_timeout():
	health = max_health
	call_deferred("set_monitorable",true)
	show()
