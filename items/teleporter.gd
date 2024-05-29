extends Interactable_script

@export var location:String = "res://levels/level_1.tscn"

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var animated_sprite_2d_2 = $AnimatedSprite2D2

func _ready():
	var rand = randi_range(0,5)
	animated_sprite_2d.frame = rand
	animated_sprite_2d_2.frame = rand
