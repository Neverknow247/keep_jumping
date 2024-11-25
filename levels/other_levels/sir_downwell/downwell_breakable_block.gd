extends StaticBody2D

var sir_downwell_stats = SirDownwellStats

@export var type = 0

var gem_fragment = preload("res://levels/other_levels/sir_downwell/gem_fragments.tscn")

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

var random_gem_chance

func _ready():
	random_gem_chance = sir_downwell_stats.rng.randi_range(1,10)
	#sprite_2d.texture = textures[type]
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
	queue_free()
	#if respawn:
		#animation_player.play("RESET")
		#monitor = true
	#else:
		#timer.start()

func _on_hurtbox_hurt(hitbox, damage):
	if monitor == true and random_gem_chance == 9 and damage != 0:
		sir_downwell_stats.instantiate_scene_on_world(gem_fragment,global_position)
	queue_free()

func summon_gem_fragment():
	var new_gem_fragment = gem_fragment.instantiate()
	get_tree().current_scene.add_child(new_gem_fragment)
	new_gem_fragment.global_position = global_position
