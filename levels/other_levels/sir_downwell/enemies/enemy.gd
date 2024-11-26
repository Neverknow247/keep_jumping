extends CharacterBody2D

var sir_downwell_stats = SirDownwellStats

@onready var character_stats = $character_stats
@onready var sprite_2d = $Sprite2D
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var hurtbox = $hurtbox
@onready var _hitbox = $hitbox
@onready var nav_agent = $nav_agent
@onready var floor_cast = $floor_cast
@onready var wall_cast = $wall_cast

@export var max_speed = 30.0
@export var hurt_speed = 80.0
@export var acceleration = 100
@export var gravity = 200
@export var enemy_type = 0

@onready var current_speed = max_speed

#slime stats
@export var turns_at_ledges = true
@export var face_left = false
@export var face_direction = 1.0
@export var updated_direction = false

#worm stats
enum direction {LEFT = -1, RIGHT = 1}
var crawling_direction = direction.RIGHT

var target = null
var state = 0

signal die

func _ready():
	target = get_tree().current_scene.player
	set_physics_process(false)

func _physics_process(delta):
	if target != null:
		state_machine(delta)

func state_machine(delta):
	match enemy_type:
		0:
			pass
		1:
			walk(delta)
		2:
			chase_target(delta)
		3:
			crawl(delta)

func turn_around():
	face_direction *= -1
	position.x = position.x+face_direction*2


#slime mechanics
func walk(delta):
	if !updated_direction:
		if sir_downwell_stats["rng"].randi_range(0,1) == 0:
			face_direction = -1
		updated_direction = true
	if not is_on_floor():
		velocity.y += gravity * delta
	if is_on_wall():
		turn_around()
	if is_at_ledge() and turns_at_ledges:
		turn_around()
	velocity.x = face_direction*current_speed
	animated_sprite_2d.flip_h = face_direction == -1
	sprite_2d.flip_h = face_direction == -1
	move_and_slide()

func is_at_ledge():
	return is_on_floor() and not floor_cast.is_colliding()


#bat mechanics
func chase_target(delta):
	fly_toward_position(target.global_position,delta)

func fly_toward_position(new_position,delta):
	var direction = nav_agent.get_next_path_position() - global_position
	direction = direction.normalized()
	velocity = velocity.move_toward(direction*max_speed, acceleration*delta)
	move_and_slide()

func make_nav_path():
	if target != null:
		nav_agent.target_position = (target.global_position-Vector2(0,8))

func _on_nav_check_timer_timeout():
	make_nav_path()

#worm mechanics
func crawl(delta):
	if !updated_direction:
		if sir_downwell_stats["rng"].randi_range(0,1) == 0:
			crawling_direction = direction.LEFT
		wall_cast.target_position.x *= crawling_direction
		updated_direction = true
	if wall_cast.is_colliding():
		global_position = wall_cast.get_collision_point()
		var wall_normal = wall_cast.get_collision_normal()
		rotation = wall_normal.rotated(deg_to_rad(90)).angle()
	else:
		floor_cast.rotation_degrees = -max_speed * crawling_direction * delta
		if floor_cast.is_colliding():
			global_position = floor_cast.get_collision_point()
			var floor_normal = floor_cast.get_collision_normal()
			rotation = floor_normal.rotated(deg_to_rad(90)).angle()
		else:
			rotation_degrees += crawling_direction * 2
	if !floor_cast.is_colliding():
		pass

func _on_character_stats_died():
	Sounds.play_sfx("enemy_die", randf_range(1.0,1.5), -5)
	die.emit()
	queue_free()

func _on_visible_on_screen_notifier_2d_screen_entered():
	set_physics_process(true)

func _on_hurtbox_hurt(hitbox, damage):
	character_stats.health -= damage

func _on_stomp_box_hurt(hitbox, damage):
	character_stats.health -= damage
