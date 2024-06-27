extends StaticBody2D

@export var platform_type = 0

var textures = [
	preload("res://assets/art/items/oneway_platform.png"),
	preload("res://assets/art/items/black_oneway_platform.png"),
	preload("res://assets/art/items/sand_oneway_platform.png"),
]

@onready var sprite_2d = $Sprite2D

func _ready():
	sprite_2d.texture = textures[platform_type]
