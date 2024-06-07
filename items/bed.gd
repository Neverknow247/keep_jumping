extends Area2D

var sounds = Sounds

@export var max_health = 3
@onready var health = max_health
@export var bounce = 200
@export var infinite = false

var timer_time = 3
var bed_level = "res://levels/challenges/challenge_8.tscn"

@onready var collision_shape_2d = $CollisionShape2D
@onready var sprite_2d = $Sprite2D
@onready var timer = $Timer
@onready var reset_timer = $reset_timer
@onready var teleporter = $teleporter

func _ready():
	teleporter.hide()

func hit(damage):
	reset_timer.start()
	health -= damage
	if health <= 0:
		teleporter.show()
		timer.start()

func _on_timer_timeout():
	sounds.play_sfx("tellyin")
	get_tree().call_deferred("change_scene_to_file",bed_level)

func _on_reset_timer_timeout():
	health = max_health
