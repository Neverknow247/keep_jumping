extends Area2D

const sprites = [
	preload("res://assets/art/items/spring2.png"),
	preload("res://assets/art/items/gold_spring.png"),
	preload("res://assets/art/items/purple_spring.png")
]

@export var max_health = 1
@onready var health = max_health
@export var bounce = 200
@export var infinite = false
@export var halloween = false

var timer_time = 3

@onready var collision_shape_2d = $CollisionShape2D
@onready var sprite_2d = $Sprite2D
@onready var halloween_sprite = $halloween_sprite
@onready var timer = $Timer

func _ready():
	if halloween:
		sprite_2d.hide()
		halloween_sprite.show()
		infinite = true
		max_health = 1
		health = 1
	else:
		sprite_2d.texture = sprites[min(health-1,2)]

func hit(damage):
	if infinite:
		return
	health -= damage
	if health <= 0:
		call_deferred("set_monitorable",false)
		hide()
		timer.start(timer_time*max_health)
		print("spawn spring")
	else:
		sprite_2d.texture = sprites[min(health-1,2)]

func _on_timer_timeout():
	health = max_health
	sprite_2d.texture = sprites[min(health-1,2)]
	call_deferred("set_monitorable",true)
	show()
