extends CharacterBody2D

var sounds = Sounds
var stats = Stats

@export var acceleration = 512
@export var friction = 10
const SPEED = 64
const JUMP_VELOCITY = 128
@export var wall_slide_speed = 42
@export var max_wall_slide_speed = 128

@export var stomp_impulse = 75.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var sprite = $Sprite2D
@onready var animator = $AnimationPlayer
@onready var coyote_jump_timer = $coyote_jump_timer
@onready var blink_animator = $blink_animator

enum {
	MOVE,
	WALL_SLIDE
}

var state = MOVE
var just_jumped = false
var double_jump = true
var invincible = false

func _physics_process(delta):
	just_jumped = false
	
	match state:
		MOVE:
			apply_gravity(delta)
			jump_check()
			var input_vector = get_input_vector()
			apply_horizontal_force(input_vector, delta)
			update_animations(input_vector)
			move()
			wall_slide_check()
		WALL_SLIDE:
			var input_vector = get_input_vector()
			var wall_axis = get_wall_axis()
			if wall_axis !=0:
				sprite.scale.x = wall_axis
			animator.play("wall_slide")
			wall_slide_jump_check(wall_axis)
			wall_slide_drop(delta)
			move_and_slide()
			wall_detach(delta, wall_axis, input_vector)

func create_walk_sound():
	sounds.play_sound("step", randf_range(0.6,1.2), -15)

func apply_gravity(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
		velocity.y = min(velocity.y, JUMP_VELOCITY)

func jump_check():
	if is_on_floor() or coyote_jump_timer.time_left > 0:
		if Input.is_action_just_pressed("jump"):
			jump(JUMP_VELOCITY)
			just_jumped = true
	else:
		if Input.is_action_just_released("jump") and velocity.y < -JUMP_VELOCITY/2:
			velocity.y = -JUMP_VELOCITY/2
		if Input.is_action_just_pressed("jump") and double_jump:
			jump(JUMP_VELOCITY*.75)
			double_jump = false

func jump(force):
	velocity.y = -force

func get_input_vector():
	var x_input = Input.get_action_strength("right") - Input.get_action_strength("left")
	return Vector2(x_input, 0)

func apply_horizontal_force(input_vector, delta):
	if input_vector.x != 0:
		velocity.x += input_vector.x * acceleration * delta
		velocity.x = clamp(velocity.x, -SPEED, SPEED)
	else:
		if input_vector.x == 0 and is_on_floor():
			velocity.x = move_toward(velocity.x, 0, friction)

func update_animations(input_vector):
	var facing = input_vector.x
	if facing !=0:
		sprite.scale.x = facing
	if not is_on_floor():
#		if velocity.y > 0:
		animator.play("jump")
#		else:
	elif input_vector.x != 0:
		animator.play("walk")
	else: animator.play("idle")

func move():
	var was_in_air = not is_on_floor()
	var was_on_floor = is_on_floor()
	var last_velocity = velocity
	var last_position = position
	
	move_and_slide()
	
	if was_in_air and is_on_floor():
		create_walk_sound()
		velocity.x = last_velocity.x
		double_jump = true
	
	if was_on_floor and not is_on_floor() and not just_jumped:
		coyote_jump_timer.start()


func wall_slide_check():
	if not is_on_floor() and is_on_wall():
		state = WALL_SLIDE
		double_jump = true

func get_wall_axis():
	var is_right_wall = test_move(transform,Vector2.RIGHT)
	var is_left_wall = test_move(transform,Vector2.LEFT)
	return int(is_left_wall) - int(is_right_wall)

func wall_slide_jump_check(wall_axis):
	if Input.is_action_just_pressed("jump"):
		velocity.x = wall_axis * SPEED
		velocity.y = -JUMP_VELOCITY/1.25
		state = MOVE

func wall_slide_drop(delta):
	var max_slide_speed = wall_slide_speed
	if Input.is_action_pressed("down"):
		max_slide_speed = max_wall_slide_speed
	velocity.y = min(velocity.y + gravity * delta, max_slide_speed)

func wall_detach(delta, wall_axis, input_vector):
	if Input.is_action_just_pressed("right") or Input.is_action_just_pressed("left"):
		velocity.x = input_vector.x * acceleration * delta
		state = MOVE
	if wall_axis == 0 or is_on_floor():
		state = MOVE

func _on_hurt_box_hit(damage):
	if not invincible:
		invincible = true
		blink_animator.play("blink")
		sounds.play_sound("player_hurt", 1, -5)
		stats.player_health -= damage
		stats.damage_taken += damage
		check_death()
	else:
		print("nah im inv")

func set_invincible(_bool):
	invincible = _bool

func check_death():
	if stats.player_health <= 0:
		get_tree().reload_current_scene()

func _on_hit_box_area_entered(area):
	velocity = calculate_stomp_velocity(velocity, stomp_impulse)

func calculate_stomp_velocity(linear_velocity: Vector2, impulse):
	var out: = linear_velocity
	out.y = -impulse
	return out
