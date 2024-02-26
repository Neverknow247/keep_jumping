extends ParallaxBackground

@export var closest_texture: Texture
@export var close_texture: Texture
@export var far_texture: Texture
@export var furthest_texture: Texture

@onready var furthest_sprite = $furthest/furthest_sprite
@onready var far_sprite = $far/far_sprite
@onready var close_sprite = $close/close_sprite
@onready var closest_sprite = $closest/closest_sprite


# Called when the node enters the scene tree for the first time.
func _ready():
	set_textures()

func set_textures():
	furthest_sprite.texture = furthest_texture
	far_sprite.texture = far_texture
	close_sprite.texture = close_texture
	closest_sprite.texture = closest_texture

