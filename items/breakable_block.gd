extends StaticBody2D

@export var type = 0

var textures = [
	preload("res://assets/art/items/breakable_block.png"),
	preload("res://assets/art/items/breakable_sand_block.png"),
	preload("res://assets/art/items/breakable_lava_block.png"),
]

@onready var sprite_2d = $Sprite2D
@onready var animation_player = $AnimationPlayer
@onready var timer = $Timer

var monitor = true
var respawn = true

func _ready():
	sprite_2d.texture = textures[type]
	var rand = randi_range(0,3)
	sprite_2d.frame = rand

@warning_ignore("unused_parameter")
func _on_area_2d_body_entered(body):
	respawn = false
	if monitor:
		animation_player.play("break")
		monitor = false

@warning_ignore("unused_parameter")
func _on_area_2d_body_exited(body):
	respawn = true

func _on_timer_timeout():
	if respawn:
		animation_player.play("RESET")
		monitor = true
	else:
		timer.start()


