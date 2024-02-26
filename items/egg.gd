extends Area2D

@export var texture : Texture
@export var texture_h_frames : int = 1
@export_enum("Dog", "Hat", "Level", "Mystery") var egg_type: String
@export var level_unlock : String
@export var ninja_egg: bool = false


@onready var sprite_2d = $Sprite2D
@onready var animation_player = $AnimationPlayer

@onready var text = $text

func _ready():
	sprite_2d.texture = texture
	sprite_2d.hframes = texture_h_frames
	play_animation()

func play_animation():
	if texture_h_frames > 1:
		animation_player.play(str(texture_h_frames))

func ninja_text():
	text.visible = true
