extends RigidBody2D

@onready var sprite = $sprite

var rotation_amount = randf_range(-.1,.1)
var direction = 1


func _ready():
	_apply_frame()
	_apply_constant_force()

func _physics_process(delta):
	sprite.rotate(rotation_amount)

func _apply_frame():
	var rand = randi_range(0,3)
	sprite.frame = rand
	
func _apply_constant_force():
	var rand_x = randi_range(10*direction,20*direction)
	var rand_y = randi_range(-3,3)
	constant_force = Vector2(rand_x,rand_y)

func _on_queue_free_timer_timeout():
	queue_free()
