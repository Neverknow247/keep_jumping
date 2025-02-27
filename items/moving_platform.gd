extends AnimatableBody2D

var stats = Stats

@export var distance:Vector2
@export var phase_time:float = 6.0
@export_range(0.0, 1.0) var phase_offset:float
@export var debug:bool = false

@export var texture_index = 0
var textures = [
	preload("res://assets/art/items/moving_platform.png"),
	preload("res://assets/art/items/space_moving_platform.png"),
	preload("res://assets/art/items/black_moving_platform.png"),
	preload("res://assets/art/items/lava_moving_platform.png"),
	preload("res://assets/art/items/moving_platform_halloween.png"),
]

@onready var sprite = $sprite

var pivot:Vector2
var time:float

var movable = true
var reset_unlocked = false

func _ready():
	pivot = global_position
	set_texture()
	reset_unlocked = stats.calc_total_reunions()>0

func _input(event):
	if (event.is_action("reset_platforms") || event.is_action("controller_reset_platforms")) and movable and reset_unlocked:
		time = 0.0

func set_texture():
	sprite.texture = textures[texture_index]

func get_pos(t:float)->Vector2:
	var x:float = pivot.x + cos(TAU * (t+phase_offset)) * distance.x
	var y:float = pivot.y + sin(TAU * t) * distance.y
	return Vector2(x,y)

func _physics_process(delta):
	time = fmod(time + delta/phase_time, 1.0)
	global_position = get_pos(time)

@warning_ignore("unused_parameter")
func _process(delta):
	queue_redraw()

func _draw():
	if !debug:
		return
	var resolution:int = 20
	var increments:float = 1.0/resolution
	for i in resolution:
		var a: = get_pos(increments * i) - global_position
		var b: = get_pos(increments * (i+1)) - global_position
		draw_line(a, b, Color.WHITE, -1)

@warning_ignore("unused_parameter")
func _on_player_sense_body_entered(body):
	movable = false

@warning_ignore("unused_parameter")
func _on_player_sense_body_exited(body):
	movable = true
