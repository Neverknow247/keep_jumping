extends Node

signal died
signal health_changed(value)

@export var max_health = 1
@onready var health = max_health : set = set_health

func set_health(value):
	health = clamp(value,0,max_health)
	health_changed.emit(value)
	if health <= 0:
		died.emit()
