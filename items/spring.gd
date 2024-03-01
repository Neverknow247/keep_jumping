extends Area2D

const sprites = [
	preload("res://assets/art/items/spring2.png"),
	preload("res://assets/art/items/gold_spring.png"),
	preload("res://assets/art/items/purple_spring.png")
]

@export var max_health = 1
@onready var health = max_health
@export var bounce = 200

var timer_time = 5

@onready var collision_shape_2d = $CollisionShape2D
@onready var sprite_2d = $Sprite2D
@onready var timer = $Timer

func _ready():
	sprite_2d.texture = sprites[max_health-1]

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
