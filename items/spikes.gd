extends StaticBody2D

@export var type = 0

@onready var sprite_2d = $Sprite2D

const sprites = [
	preload("res://assets/art/items/forest_spikes.png"),
	preload("res://assets/art/items/Spikes.png"),
	preload("res://assets/art/items/space_spikes.png"),
]

var damage = 1

func _ready():
	sprite_2d.texture = sprites[type]
