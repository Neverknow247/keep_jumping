extends Node2D

@export var speed = 250
@export var damage = 1

var velocity = Vector2.ZERO

func _ready():
	update_velocity()

func _physics_process(delta):
	position += velocity*delta

func update_velocity():
	velocity.y = speed

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

func _on_hitbox_area_entered(area):
	queue_free()

func _on_hitbox_body_entered(body):
	queue_free()
