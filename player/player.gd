extends CharacterBody2D

var sounds = Sounds
var stats = Stats
var global_timer = GlobalTimer
var rng = RandomNumberGenerator.new()

signal respawn
signal change_scene(new_scene)

const step_particles = preload("res://particles/step_particles.tscn")

func add_particle():
	var part = step_particles.instantiate()
	get_parent().add_child(part)
	part.modulate = Color(stats.ground_color)
	part.position = global_position

var current_velocity = 0.0
@export var acceleration = 512
@export var default_max_velocity = 65
@export var sand_max_velocity = 30
@export var max_velocity :float = 65.0
@export var ledge_bonus = 3.5
@export var b_hop_bonus_multiplier = 20
@export var friction = 512
@export var wall_friction = .02
@export var ground_friction = .2
@export var jump_force = 150
@export var partial_jump_multiplier = .9
@export var air_friction = 90
@export var fall_bonus = .05
@export var default_max_fall_velocity:float = 128.0
@export var max_fall_velocity = 150
@export var default_gravity = 300
@export var space_gravity = 150
@export var gravity = 300
@export var sand_gravity = 75
@export var default_wall_slide_speed = 150
@export var space_wall_slide_speed = 75
@export var wall_slide_speed = 150
@export var wall_slide_bonus = .1
@export var max_wall_slide_speed = 150
@export var slope_speed = 150
@export var slope_gravity = 300
@export var stomp_impulse = 75.0
@export var stomp_bonus = .1

@onready var sprite = $sprite
@onready var interact_icon = $interact_icon
@onready var coyote_jump_timer = $coyote_jump_timer
@onready var coyote_wall_timer = $coyote_wall_timer
@onready var jump_timer = $jump_timer
@onready var collision = $collision
@onready var jump_collision = $jump_collision
@onready var start_collision = $start_collision
@onready var hit_box = $hit_box
@onready var hurt_box = $hurt_box
@onready var interaction_detection = $interaction_detection
@onready var animation_player = $AnimationPlayer

var state = "move_state"
var in_sand = false
var just_jumped = false
var double_jump_color = Color.WHITE
var double_jump = true:
	get:
		return double_jump
	set(value):
		double_jump = value
		if double_jump == true:
			sprite.modulate = Color.WHITE
		else:
			sprite.modulate = double_jump_color

var in_space = false
var spike_count = 0
var checkpoint = false
var invincible = false
var tile_map = null

func _ready():
	Utils.change_color_blind_textures.connect(set_color_blind_colors)
	set_color_blind_colors()
	rng.randomize()

func set_color_blind_colors():
	if Utils.color_blind_mode:
		double_jump_color = Color("#5aae00")
	else:
		double_jump_color = Color("#ff4568")

func _physics_process(delta):
	current_velocity = abs(velocity.x)
	var callable = Callable(self,state)
	callable.call(delta)

func create_walk_sound():
	@warning_ignore("narrowing_conversion")
	sounds.play_sfx("step", randf_range(0.7,1.2), -25)
	@warning_ignore("narrowing_conversion")
	sounds.play_sfx("chain_step_1", randf_range(0.8,0.9), -20)
	@warning_ignore("narrowing_conversion")
	sounds.play_sfx("chain_step_2", randf_range(0.8,0.9), -20)
	stats["save_data"]["stats"]["Steps Taken"] += 1
	if stats["save_data"]["stats"]["Steps Taken"] >= 2200 and !stats["save_data"]["achievements"]["step_1"]:
		GlobalSteam.setAchievement("ACH_MILE")
		stats["save_data"]["achievements"]["step_1"] = true
	if stats["save_data"]["stats"]["Steps Taken"] >= 25214 and !stats["save_data"]["achievements"]["step_2"]:
		GlobalSteam.setAchievement("ACH_HALF_MARATHON")
		stats["save_data"]["achievements"]["step_2"] = true
	if stats["save_data"]["stats"]["Steps Taken"] >= 52427 and !stats["save_data"]["achievements"]["step_3"]:
		GlobalSteam.setAchievement("ACH_MARATHON")
		stats["save_data"]["achievements"]["step_3"] = true
	add_particle()

func create_get_up_sound():
	@warning_ignore("narrowing_conversion")
	sounds.play_sfx("step", randf_range(0.7,1.2), -25)
	@warning_ignore("narrowing_conversion")
	sounds.play_sfx("chain_step_1", randf_range(0.8,0.9), -20)
	@warning_ignore("narrowing_conversion")
	sounds.play_sfx("chain_step_2", randf_range(0.8,0.9), -20)
	stats["save_data"]["stats"]["Steps Taken"] += 1
	add_particle()

func set_physics():
	match state:
		"move_state":
			gravity = default_gravity
		"sand_state":
			gravity = sand_gravity

func move_state(delta):
	set_physics()
	apply_gravity(delta)
	var input_axis = get_input_axis()
	if is_moving(input_axis):
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
		apply_acceleration(delta,input_axis)
	else:
		apply_friction(delta)
	jump_check()
	var was_on_floor = is_on_floor()
	var was_on_wall = is_on_wall()
	fall_bonus_check()
	update_animations(input_axis)
	var wall
	if Utils.wall_frame_buffer:
		wall = false
	else:
		wall = wall_check()
	var on_slope = slope_check()
	move_and_slide()
	if Utils.wall_frame_buffer:
		if was_on_wall and is_on_wall():
			wall = wall_check()
	if !was_on_floor and is_on_floor():
		@warning_ignore("narrowing_conversion")
		sounds.play_sfx("step", randf_range(0.7,1), -23)
		@warning_ignore("narrowing_conversion")
		sounds.play_sfx("chain_step_2", randf_range(0.8,0.9), -20)
	var just_left_edge = was_on_floor and not is_on_floor() and velocity.y >= 0
	if just_left_edge:
		coyote_jump_timer.start()
	if on_slope and slope_check(): change_to_slope()
	var just_left_wall = was_on_wall and not is_on_wall()
	if just_left_wall and wall != false:
		coyote_wall_timer.start()
	reset_velocity_check()

func sand_state_enter(delta):
	if velocity.y <0:
		velocity.y = max(velocity.y,sign(velocity.y)*10)
	else:
		velocity.y = min(velocity.y,sign(velocity.y)*10)
	state = "sand_state"

func sand_state(delta):
	#double_jump = true
	set_physics()
	apply_gravity(delta)
	#var input_axis = get_input_axis()
	#if is_moving(input_axis):
		#Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
		#apply_acceleration(delta,input_axis)
	#else:
	apply_friction(delta)
	jump_check()
	move_and_slide()

func apply_gravity(delta):
	velocity.y = move_toward(velocity.y, max_fall_velocity, gravity * delta)

func apply_space(enter):
	if enter:
		in_space = true
		gravity = space_gravity
		wall_slide_speed = space_wall_slide_speed
	else:
		in_space = false
		gravity = default_gravity
		wall_slide_speed = default_wall_slide_speed

func get_input_axis():
	var input_axis = 0
	if Input.get_axis("controller_left", "controller_right") != 0:
		input_axis = Input.get_axis("controller_left", "controller_right")
	if Input.get_axis("left", "right") != 0:
		input_axis = Input.get_axis("left", "right")
	return signi(input_axis)

func is_moving(input_axis):
	return input_axis != 0

func apply_acceleration(delta, input_axis):
	velocity.x = move_toward(velocity.x, input_axis * max_velocity, acceleration * delta)

func apply_friction(delta):
	if is_on_floor() || state == "sand_state":
		velocity.x = move_toward(velocity.x, 0, friction * delta)
	else:
		velocity.x = move_toward(velocity.x, 0, air_friction * delta)

func jump_check():
	if is_on_floor():
		double_jump = true
	if coyote_wall_timer.time_left > 0.0:
		if Input.is_action_just_pressed("jump") || Input.is_action_just_pressed("controller_jump"):
			jump(jump_force)
	elif is_on_floor() or coyote_jump_timer.time_left > 0.0 or in_sand:
		if Input.is_action_just_pressed("jump") || Input.is_action_just_pressed("controller_jump"):
			max_velocity = max(default_max_velocity,current_velocity)
			if coyote_jump_timer.time_left > 0.0:
				max_velocity += ledge_bonus-(coyote_jump_timer.time_left*2)
			coyote_jump_timer.stop()
			jump(jump_force)
	elif not is_on_floor():
		if just_jumped and (Input.is_action_just_released("jump")|| Input.is_action_just_released("controller_jump")) and velocity.y < -jump_force / 2:
			velocity.y = -jump_force / 2
		if (Input.is_action_just_pressed("jump")||Input.is_action_just_pressed("controller_jump")) and double_jump:
			#print("jump air")
			jump(jump_force * partial_jump_multiplier)
			double_jump = false

func jump(force):
	just_jumped = true
	jump_timer.start()
	velocity.y = -force
	@warning_ignore("narrowing_conversion")
	sounds.play_sfx("chain_step_1", randf_range(0.9,1), -25)
	@warning_ignore("narrowing_conversion")
	sounds.play_sfx("chain_damage_2", randf_range(0.9,1), -25)
	stats["save_data"]["stats"]["Jumped"] += 1
	if stats["save_data"]["stats"]["Jumped"] >= 1000 and !stats["save_data"]["achievements"]["jump_1"]:
		GlobalSteam.setAchievement("ACH_JUMP")
		stats["save_data"]["achievements"]["jump_1"] = true
	if stats["save_data"]["stats"]["Jumped"] >= 25000 and !stats["save_data"]["achievements"]["jump_2"]:
		GlobalSteam.setAchievement("ACH_JUMP_2")
		stats["save_data"]["achievements"]["jump_2"] = true
	if stats["save_data"]["stats"]["Jumped"] >= 100000 and !stats["save_data"]["achievements"]["jump_3"]:
		GlobalSteam.setAchievement("ACH_JUMP_3")
		stats["save_data"]["achievements"]["jump_3"] = true

func fall_bonus_check():
	if is_on_floor():
		max_fall_velocity = default_max_fall_velocity
	else:
		if Input.is_action_pressed("down") || Input.is_action_pressed("controller_down"):
			max_fall_velocity+=fall_bonus

func update_animations(input_vector):
	var facing = input_vector
	if facing !=0:
		sprite.scale.x = facing
		jump_collision.scale.x = facing
		$hurt_box/collision2.scale.x = facing
	if not is_on_floor():
		animation_player.stop()
		jump_collision.disabled = false
		collision.disabled = true
		$sprite/hat.position = Vector2(0,0)
		if velocity.y <= 0:
			sprite.frame = 18
		else:
			sprite.frame = 19
	elif input_vector != 0:
		collision.disabled = false
		jump_collision.disabled = true
		animation_player.play("run")
	else: 
		collision.disabled = false
		jump_collision.disabled = true
		animation_player.play("idle")

func wall_check():
	if not is_on_floor() and is_on_wall():
		var tile_id
		for i in get_slide_collision_count():
			@warning_ignore("shadowed_variable")
			var collision = get_slide_collision(i)
			if collision.get_collider() is TileMap:
				var tilemap = collision.get_collider()
				var contact_point = collision.get_position()
				var cell_pos = tilemap.local_to_map(contact_point)
				if sign(get_wall_normal().x) == 1:
					cell_pos = Vector2i(int(cell_pos.x)-1,int(cell_pos.y))
				else:
					cell_pos = Vector2i(int(cell_pos.x),int(cell_pos.y))
				tile_id = tilemap.get_cell_atlas_coords(0,cell_pos)
		if tile_id == Vector2i(12,15):
			return false
			#print("stop",tile_id)
		else:
			@warning_ignore("narrowing_conversion")
			sounds.play_sfx("step", randf_range(0.7,1), -20)
			@warning_ignore("narrowing_conversion")
			sounds.play_sfx("chain_step_2", randf_range(0.8,0.9), -15)
			state = "wall_slide_state"
			max_velocity = max(max_velocity-wall_friction,default_max_velocity)
			double_jump = true

#func change_wall_slide_state():
	#@warning_ignore("narrowing_conversion")
	#sounds.play_sfx("step", randf_range(0.7,1), -20)
	#@warning_ignore("narrowing_conversion")
	#sounds.play_sfx("chain_step_2", randf_range(0.8,0.9), -15)
	#state = wall_slide_state
	#max_velocity = max(max_velocity-wall_friction,default_max_velocity)
	#double_jump = true

func reset_velocity_check():
	if is_on_floor():
		max_velocity = max(max_velocity-ground_friction,default_max_velocity)

func wall_slide_state(delta):
	animation_player.stop()
	collision.disabled = false
	var wall_normal = sign(get_wall_normal().x)
	if wall_normal !=0:
		sprite.scale.x = wall_normal
	if velocity.y <= 0:
		sprite.frame = 24
	else:
		sprite.frame = 25
	velocity.y = clampf(velocity.y, -max_fall_velocity, max_fall_velocity)
	wall_jump_check(wall_normal)
	apply_wall_slide_gravity(delta)
	move_and_slide()
	wall_detach(delta)

func wall_jump_check(wall_axis):
	if Input.is_action_just_pressed("jump")||Input.is_action_just_pressed("controller_jump"):
		#print(wall_axis)
		velocity.x = wall_axis*default_max_velocity
		state = "move_state"
		#print("wall jump")
		jump(jump_force*partial_jump_multiplier)

func apply_wall_slide_gravity(delta):
	var slide_speed = wall_slide_speed
	if Input.is_action_pressed("down") || Input.is_action_pressed("controller_down"):
		slide_speed = max_fall_velocity
		max_fall_velocity+=wall_slide_bonus
	else:
		slide_speed = wall_slide_speed
	velocity.y = move_toward(velocity.y, slide_speed, gravity * delta)

func wall_detach(delta):
	if Input.is_action_just_pressed("right") || Input.is_action_just_pressed("controller_right"):
		velocity.x = acceleration * delta
		coyote_wall_timer.start()
		state = "move_state"
	if Input.is_action_just_pressed("left") || Input.is_action_just_pressed("controller_left"):
		velocity.x = -acceleration * delta
		coyote_wall_timer.start()
		state = "move_state"
	if not is_on_wall() and not is_on_ceiling() or is_on_floor():
		state = "move_state"

func slope_check():
	if get_floor_angle() < .9 and get_floor_angle() > .7:
		return true

func change_to_slope():
		state = "slope_state"
		velocity = Vector2.ZERO
		double_jump = false
		stats["save_data"]["stats"]["Slope Slides"] += 1
		if stats["save_data"]["stats"]["Slope Slides"] >= 100 and !stats["save_data"]["achievements"]["slope_1"]:
			GlobalSteam.setAchievement("ACH_SLOPE")
			stats["save_data"]["achievements"]["slope_1"] = true
		if stats["save_data"]["stats"]["Slope Slides"] >= 500 and !stats["save_data"]["achievements"]["slope_2"]:
			GlobalSteam.setAchievement("ACH_SLOPE_2")
			stats["save_data"]["achievements"]["slope_2"] = true
		if stats["save_data"]["stats"]["Slope Slides"] >= 5000 and !stats["save_data"]["achievements"]["slope_3"]:
			GlobalSteam.setAchievement("ACH_SLOPE_3")
			stats["save_data"]["achievements"]["slope_3"] = true
		SaveAndLoad.update_save_data()
	

@warning_ignore("unused_parameter")
func slope_state(delta):
	velocity.y = slope_speed
	move_and_slide()
	slope_exit()

func slope_exit():
	if get_floor_angle() < .9 and get_floor_angle() > .7:
		pass
	else:
		if get_floor_angle() == 0:
			state = "move_state"

@warning_ignore("unused_parameter")
func _on_hurt_box_hit(damage):
	if not invincible:
		invincible = true
		var rand = rng.randi_range(1,18)
		@warning_ignore("narrowing_conversion")
		sounds.play_sfx("hurt_%s"%[str(rand)],randf_range(0.9,1),0)
		@warning_ignore("narrowing_conversion")
		sounds.play_sfx("chain_damage_1",randf_range(0.8,1),0)
		@warning_ignore("narrowing_conversion")
		sounds.play_sfx("chain_damage_2",randf_range(0.9,1.1),0)
		check_death()
	else:
		pass

func set_invincible(_bool):
	invincible = _bool

func check_death():
	apply_space(false)
	spike_count += 1
	stats["save_data"]["current_run_data"]["spike_count"] += 1
	stats["save_data"]["stats"]["Spiked"] += 1
	if stats["save_data"]["stats"]["Spiked"] >= 100 and !stats["save_data"]["achievements"]["spike_1"]:
		GlobalSteam.setAchievement("ACH_SPIKE")
		stats["save_data"]["achievements"]["spike_1"] = true
	if stats["save_data"]["stats"]["Spiked"] >= 500 and !stats["save_data"]["achievements"]["spike_2"]:
		GlobalSteam.setAchievement("ACH_SPIKE_2")
		stats["save_data"]["achievements"]["spike_2"] = true
	if stats["save_data"]["stats"]["Spiked"] >= 5000 and !stats["save_data"]["achievements"]["spike_3"]:
		GlobalSteam.setAchievement("ACH_SPIKE_3")
		stats["save_data"]["achievements"]["spike_3"] = true
	SaveAndLoad.update_save_data()
	if stats["save_data"]["hard_mode"]:
		stats.reset_run()
		change_scene.emit()
	else:
		respawn.emit()

@warning_ignore("unused_parameter")
func _on_hit_box_area_entered(area):
	if velocity.y>0:
		double_jump = true
		var bounce = area.bounce * (((area.max_health-area.health)*.25)+1)
		velocity = calculate_stomp_velocity(velocity, bounce)
		max_velocity += stomp_bonus
		@warning_ignore("narrowing_conversion")
		sounds.play_sfx("player_jump",randf_range(0.8,1.4),-5)
		area.hit(1)
		stats["save_data"]["stats"]["Spring Bounced"] += 1

func calculate_stomp_velocity(linear_velocity: Vector2, impulse):
	var out: = linear_velocity
	out.y = -impulse
	return out

func _on_jump_timer_timeout():
	just_jumped = false

func paused():
	state = "pause_state"

func credits_roll():
	collision.call_deferred("set_disabled",true)
	jump_collision.call_deferred("set_disabled",true)
	start_collision.call_deferred("set_disabled",true)
	hit_box.call_deferred("set_monitorable",false)
	hit_box.call_deferred("set_monitoring",false)
	hurt_box.call_deferred("set_monitorable",false)
	hurt_box.call_deferred("set_monitoring",false)
	interaction_detection.call_deferred("set_monitorable",false)
	interaction_detection.call_deferred("set_monitoring",false)

@warning_ignore("unused_parameter")
func pause_state(delta):
	pass

var opening_state = false
func open_state(delta):
	if opening_state:
		opening_state = false
		animation_player.play("get_up")

func change_to_move_state():
	state = "move_state"

var interactable = null
var interacting = false
var interacting_type = ""

func _on_interaction_detection_area_entered(area):
	if area.unlocked:
		interactable = area
		interact_icon.show()

@warning_ignore("unused_parameter")
func _on_interaction_detection_area_exited(area):
	interactable = null
	interacting = false
	interacting_type = ""
	interact_icon.hide()
	close_interactable()

func _input(event):
	if (event.is_action_pressed("action") or event.is_action_pressed("controller_action")) && interactable != null && interactable.type != "" && !interacting:
		interacting = true
		interacting_type = interactable.type
		print(interactable.type)
		self.call("open_"+interactable.type)
	elif (event.is_action_pressed("action") or event.is_action_pressed("controller_action")) && interactable != null && interactable.type == interacting_type && interacting:
		interacting = false
		interacting_type = ""
		close_interactable()

signal close_interactables
func close_interactable():
	close_interactables.emit()

signal campfire
func open_campfire():
	campfire.emit()

signal dog_house
func open_dog_house():
	dog_house.emit()

signal leaderboard
func open_leaderboard():
	leaderboard.emit()

signal picnic
func open_picnic():
	picnic.emit()
