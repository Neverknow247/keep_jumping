extends Node

var rng = RandomNumberGenerator.new()

var default_max_air_jumps = 10
var max_air_jumps = 1
var air_jumps = 1

var level = 0

signal max_health_changed(value)
signal health_changed(value)

var default_max_health = 1
var max_health = 1:
	get:
		return max_health
	set(value):
		max_health = value

var health = 1:
	get:
		return health
	set(value):
		health = value

var gem_fragments = 0:
	get:
		return gem_fragments
	set(value):
		gem_fragments = value

func reset_sir_downwell():
	level = 0
	max_health = default_max_health
	health = default_max_health
	max_air_jumps = default_max_air_jumps
	air_jumps = default_max_air_jumps
	gem_fragments = 0

func instantiate_scene_on_world(scene:PackedScene,position:Vector2):
	var world = get_tree().current_scene
	var instance = scene.instantiate()
	world.call_deferred("add_child",instance)
	instance.global_position = position
	return instance
