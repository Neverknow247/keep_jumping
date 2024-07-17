extends StaticBody2D

var utils = Utils

@export var type = 0

@onready var sprite_2d = $Sprite2D
@onready var spike_light = $spike_light

var color_blind_sprite = preload("res://assets/art/items/color_blind_spikes.png")

const sprites = [
	preload("res://assets/art/items/forest_spikes.png"),
	preload("res://assets/art/items/Spikes.png"),
	preload("res://assets/art/items/space_spikes.png"),
	preload("res://assets/art/items/rust_spikes.png"),
	preload("res://assets/art/items/lava_spikes.png"),
	preload("res://assets/art/items/sand_spikes.png"),
	preload("res://assets/art/items/knight_forest_spikes.png"),
	preload("res://assets/art/items/knight_spikes.png"),
]

var damage = 1

func _ready():
	utils.change_color_blind_textures.connect(change_sprite)
	change_sprite()
	check_lava()

func change_sprite():
	if Utils.color_blind_mode:
		sprite_2d.texture = color_blind_sprite
	else:
		sprite_2d.texture = sprites[type]

func check_lava():
	if type == 4:
		spike_light.show()
