extends Node2D

@onready var block_body = $block_body
@onready var animation_player = $AnimationPlayer
@onready var sprite_2d = $block_body/Sprite2D
@onready var timer = $Timer

@export var type = 0
@export var fall_distance_in_blocks = 1.0
@export var health = 1

var fell = false

func _ready():
	pass

func set_sprite():
	pass

func _on_player_detection_body_entered(body):
	if !fell and timer.time_left == 0:
		animation_player.play("rumble")
		health-=1
		timer.start()

func block_fall():
	if health <= 0:
		fell = true
		var tween = get_tree().create_tween()
		tween.set_ease(Tween.EASE_IN)
		tween.tween_property(block_body,"position",Vector2(block_body.position.y,block_body.position.y+(fall_distance_in_blocks*16)),fall_distance_in_blocks/8)
	






	#@warning_ignore("narrowing_conversion")
	#sounds.play_sfx("stone_door", randf_range(0.9,1.0), 0)
