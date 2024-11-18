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

func reset_sir_downwell():
	level = 0
	max_health = default_max_health
	health = default_max_health
	max_air_jumps = default_max_air_jumps
	air_jumps = default_max_air_jumps
