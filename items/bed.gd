extends Area2D

var sounds = Sounds
var stats = Stats

@export var max_health = 3
@onready var health = max_health
@export var bounce = 200
@export var infinite = false

var timer_time = 3
@export var bed_level = "res://levels/challenges/challenge_8.tscn"
@export var bed_texture = preload("res://assets/art/items/bed.png")

@onready var collision_shape_2d = $CollisionShape2D
@onready var sprite_2d = $Sprite2D
@onready var timer = $Timer
@onready var reset_timer = $reset_timer
@onready var teleporter = $teleporter

func _ready():
	sprite_2d.texture = bed_texture
	teleporter.hide()

func hit(damage):
	reset_timer.start()
	health -= damage
	if health <= 0:
		teleporter.show()
		timer.start()

func _on_timer_timeout():
	sounds.play_sfx("tellyin")
	stats.current_challenge_level = bed_level
	get_tree().call_deferred("change_scene_to_file",bed_level)

func _on_reset_timer_timeout():
	health = max_health
