extends CharacterBody2D
class_name enemy

var sounds = Sounds

@export var max_speed: int = 10

@onready var enemy_stats = $enemy_stats

func _on_hurt_box_hit(damage):
	enemy_stats.health -= damage

func _on_enemy_stats_enemy_died():
	queue_free()
	sounds.play_sfx("enemy_die", 1, -15)
