extends CharacterBody2D

var gem_fragment_particles = preload("res://levels/other_levels/sir_downwell/gem_fragment_particles.tscn")

@export var acceleration = 250
@export var max_speed = 150

var target = null

func _ready():
	rotation = randi_range(-45,45)

func  _physics_process(delta):
	if target != null:
		var direction = global_position.direction_to(target.global_position).normalized()
		velocity = velocity.move_toward(direction*max_speed, acceleration)
		move_and_slide()
	else:
		velocity = velocity.move_toward(Vector2.UP.rotated(rotation)*10,1)
		move_and_slide()

func _on_pickup_detection_body_entered(body):
	SirDownwellStats.gem_fragments += 1
	queue_free()

func _on_player_detection_body_entered(body):
	target = body

func _on_timer_timeout():
	$pickup_detection.monitoring = true
	$player_detection.monitoring = true

func _on_lifetime_timeout():
	SirDownwellStats.instantiate_scene_on_world(gem_fragment_particles,global_position)
	queue_free()
