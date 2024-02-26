extends Node

signal enemy_died

var enemy_type = ""

@export var max_health: int = 1
@onready var health = max_health:
	get:
		return health
	set(value):
		health = clamp(value, 0, max_health)
		if health == 0:
			if enemy_type == "snail":
				Stats.snail_check()
			elif enemy_type == "fast_snail":
				Stats.fast_snail_dead()
			emit_signal("enemy_died")

