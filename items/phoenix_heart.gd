extends Node2D

var stats = Stats
var rng = RandomNumberGenerator.new()

@onready var animated_sprite_2d = $AnimatedSprite2D

func _ready():
	check_gem()

func check_gem():
	if stats.calc_total_dlc_reunions() > 0:
		show()
		check_rare()
	else:
		hide()

func check_rare():
	var rand = rng.randi_range(1,100)
	if rand == 42:
		animated_sprite_2d.play("rare")
	else:
		animated_sprite_2d.play("default")
