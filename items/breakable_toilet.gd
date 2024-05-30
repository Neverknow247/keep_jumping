extends Area2D

@export var max_health = 1
@onready var health = max_health
@export var bounce = 100

@onready var collision_shape_2d = $CollisionShape2D
@onready var sprite_2d = $Sprite2D

signal break_toilet(position)

func hit(damage):
	health -= damage
	if health <= 0:
		break_toilet.emit(global_position)
		call_deferred("queue_free")

