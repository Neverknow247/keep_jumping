extends Node2D

@export var point_1 = -16
@export var point_2 = 16
@export var speed = 40

@onready var sprite_2d = $Sprite2D

var direction = 1

func _ready():
	pass

func _process(delta):
	if direction == 1:
		sprite_2d.position.x += speed*delta
		if sprite_2d.position.x > point_2:
			direction = -1
			sprite_2d.flip_h = true
	else:
		sprite_2d.position.x -= speed*delta
		if sprite_2d.position.x < point_1:
			direction = 1
			sprite_2d.flip_h = false
