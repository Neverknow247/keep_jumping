extends Area2D

@export var max_health = 1
@onready var health = max_health
@export var bounce = 200
@export var infinite = true

@export var distance:Vector2
@export var phase_time:float = 6.0
@export_range(0.0, 1.0) var phase_offset:float
@export var debug:bool = false

@onready var collision_shape_2d = $CollisionShape2D
@onready var halloween_sprite = $halloween_sprite

var pivot:Vector2
var time:float


func _ready():
	pivot = global_position

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
func hit(damage):
	if infinite:
		return
