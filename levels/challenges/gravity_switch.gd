extends Node2D

@export var camera_2d : Camera2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_enter_space_body_entered(body):
	camera_2d.enter_space()
	body.apply_space(true)

func _on_exit_space_body_entered(body):
	camera_2d.exit_space()
	body.apply_space(false)
