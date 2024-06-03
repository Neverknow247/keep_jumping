extends Camera2D

@onready var timer = $Timer
@onready var small = $normal_particles/small
@onready var medium = $normal_particles/medium
@onready var big = $normal_particles/big
@onready var very_big = $normal_particles/very_big
@onready var animation_player = $AnimationPlayer

var shake = 0
var in_space = false

func _ready():
	Events.add_screenshake.connect(_add_screen_shake)

func enter_space():
	if !in_space:
		in_space = !in_space
		animation_player.play("particles_enter_space")

func exit_space():
	if in_space:
		in_space = !in_space
		animation_player.play("particles_exit_space")

@warning_ignore("unused_parameter")
func _process(delta):
	offset.x = randf_range(-shake,shake)
	offset.y = randf_range(-shake,shake)

func _add_screen_shake(amount,duration):
	if Utils.screen_shake:
		shake = amount
		timer.start(duration)

func _on_timer_timeout():
	shake = 0
