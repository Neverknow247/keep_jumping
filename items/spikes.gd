extends StaticBody2D

var utils = Utils

@export var type = 0

@onready var sprite_2d = $Sprite2D
@onready var spike_light = $spike_light

var color_blind_sprite = preload("res://assets/art/items/color_blind_spikes.png")
var color_blind_tiny_sprite = preload("res://assets/art/items/spikes_small.png")

const sprites = [
	#0
	preload("res://assets/art/items/forest_spikes.png"),
	#1
	preload("res://assets/art/items/Spikes.png"),
	#2
	preload("res://assets/art/items/space_spikes.png"),
	#3
	preload("res://assets/art/items/rust_spikes.png"),
	#4
	preload("res://assets/art/items/lava_spikes.png"),
	#5
	preload("res://assets/art/items/sand_spikes.png"),
	#6
	preload("res://assets/art/items/knight_forest_spikes.png"),
	#7
	preload("res://assets/art/items/knight_spikes.png"),
	#8
	preload("res://assets/art/items/candy_corn_spikes.png"),
	#9
	preload("res://assets/art/items/candy_corn_spikes_small.png"),
]

var damage = 1

func _ready():
	utils.change_color_blind_textures.connect(change_sprite)
	change_sprite()
	check_lava()

func change_sprite():
	if Utils.color_blind_mode:
		if type == 9:
			sprite_2d.texture = color_blind_tiny_sprite
		else:
			sprite_2d.texture = color_blind_sprite
	else:
		sprite_2d.texture = sprites[type]

func check_lava():
	if type == 4:
		spike_light.show()
