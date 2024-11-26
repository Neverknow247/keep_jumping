extends CharacterBody2D

var sounds = Sounds
var stats = Stats
var global_timer = GlobalTimer
var rng = RandomNumberGenerator.new()
var cosmetics = preload("res://cosmetic_resources/cosmetics.tres")

signal respawn
signal change_scene(new_scene)
@warning_ignore("unused_signal")
signal unlock_campfire

const step_particles = preload("res://particles/step_particles.tscn")

var leader_board_string = "leaderboard"

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
@export var max_sand_fall_velocity = 75
@export var default_gravity = 300
@export var space_gravity = 150
@export var gravity = 300
@export var sand_gravity = 150
#@export var sand_gravity = 75
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
@onready var jump_buffer_timer = $jump_buffer_timer
@onready var b_hop_timer = $b_hop_timer
@onready var drop_timer = $drop_timer
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
var jump_buffer = false
var in_space = false
var spike_count = 0
var checkpoint = false
var invincible = false
var tile_map = null
var damages = []

func _ready():
	set_texture()
	Utils.change_color_blind_textures.connect(set_color_blind_colors)
	set_color_blind_colors()
	rng.randomize()

func set_texture():
	var armor_index
	for i in cosmetics["armors"].size():
		if stats["save_data"]["equiped_armor"] == cosmetics["armors"][i]["armor_id"]:
			armor_index = i
	sprite.texture = cosmetics["armors"][armor_index]["armor_texture"]
	#print(stats["save_data"]["equiped_armor"])
	if stats["save_data"]["equiped_armor"] == "legless_ghost":
		jump_force = 100
	else:
		jump_force = 150
	
	
	

func set_color_blind_colors():
	if Utils.color_blind_mode:
		double_jump_color = Color("#5aae00")
	else:
		double_jump_color = Color("#3696ff")
		#double_jump_color = Color("#d743ff")
		#double_jump_color = Color("#ff4568")

func set_start_velocity():
	max_velocity = default_max_velocity
	if current_velocity > default_max_velocity:
		if velocity.x > 0:
			velocity.x = default_max_velocity
		else:
			velocity.x = -default_max_velocity

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

func move_state(delta):
	apply_gravity(delta)
	var input_axis = get_input_axis()
	if is_moving(input_axis):
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
		apply_acceleration(delta,input_axis)
	else:
		apply_friction(delta)
	if !interacting or (interacting and interacting_type == leader_board_string):
		jump_check()
		drop_check()
	var was_on_floor = is_on_floor()
	var was_on_wall = is_on_wall()
	fall_bonus_check()
	if !interacting or (interacting and interacting_type == leader_board_string):
		update_animations(input_axis)
	var wall
	if Utils.wall_frame_buffer:
		wall = false
	else:
		wall = wall_check()
	var on_slope = slope_check()
	if !interacting or (interacting and interacting_type == leader_board_string):
		move_and_slide()
	if Utils.wall_frame_buffer:
		if was_on_wall and is_on_wall():
			wall = wall_check()
	if !was_on_floor and is_on_floor():
		b_hop_timer.start()
		apply_squash()
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

@warning_ignore("unused_parameter")
func sand_state_enter(delta):
	if velocity.y <0:
		velocity.y = max(velocity.y,sign(velocity.y)*10)
	else:
		velocity.y = min(velocity.y,sign(velocity.y)*10)
	state = "sand_state"

func sand_state(delta):
	apply_sand_gravity(delta)
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

func apply_sand_gravity(delta):
	velocity.y = move_toward(velocity.y, max_sand_fall_velocity, sand_gravity * delta)

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
		reset_air_recovery_orbs()
		double_jump = true
		if jump_buffer:
			jump(jump_force)
			if b_hop_timer.time_left > 0.0:
				max_velocity+=(b_hop_timer.time_left*b_hop_bonus_multiplier)
				b_hop_timer.stop()
			jump_buffer = false
			return
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
			if b_hop_timer.time_left > 0.0:
				max_velocity+=(b_hop_timer.time_left*b_hop_bonus_multiplier)
				b_hop_timer.stop()
	elif not is_on_floor():
		if just_jumped and (Input.is_action_just_released("jump")|| Input.is_action_just_released("controller_jump")) and velocity.y < -jump_force / 2:
			velocity.y = -jump_force / 2
		if (Input.is_action_just_pressed("jump")||Input.is_action_just_pressed("controller_jump")) and double_jump:
			#print("jump air")
			jump(jump_force * partial_jump_multiplier)
			double_jump = false
		elif (Input.is_action_just_pressed("jump")||Input.is_action_just_pressed("controller_jump")) and !double_jump:
			jump_buffer_timer.start()
			jump_buffer = true

func jump(force):
	apply_stretch()
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

func drop_check():
	if Input.is_action_pressed("down") || Input.is_action_pressed("controller_down"):
		set_collision_mask_value(8,false)
		drop_timer.start()

func _on_drop_timer_timeout():
	set_collision_mask_value(8,true)

func apply_stretch():
	if Utils.squash_and_stretch:
		var tween = get_tree().create_tween()
		tween.tween_property(sprite,"scale",Vector2(.8,1.2),.1)
		tween.tween_property(sprite,"scale",Vector2(1,1),.15)

func apply_squash():
	if Utils.squash_and_stretch:
		var tween = get_tree().create_tween()
		tween.tween_property(sprite,"scale",Vector2(1.2,.8),.1)
		tween.tween_property(sprite,"scale",Vector2(1,1),.1)

func fall_bonus_check():
	if is_on_floor():
		max_fall_velocity = default_max_fall_velocity
	else:
		if Input.is_action_pressed("down") || Input.is_action_pressed("controller_down"):
			max_fall_velocity+=fall_bonus

func update_animations(input_vector):
	var facing = input_vector
	if facing !=0:
		sprite.flip_h = facing != 1
		#sprite.scale.x = facing
		jump_collision.scale.x = facing
		$hurt_box/collision2.scale.x = facing
	if not is_on_floor():
		animation_player.stop()
		#collision.disabled = true
		#jump_collision.disabled = false
		$sprite/hat.position = Vector2(0,0)
		if velocity.y <= 0:
			sprite.frame = 12
		else:
			sprite.frame = 13
	elif input_vector != 0:
		#jump_collision.disabled = true
		#collision.disabled = false
		animation_player.play("run")
	else: 
		#jump_collision.disabled = true
		#collision.disabled = false
		animation_player.play("idle")

func wall_check():
	if not is_on_floor() and is_on_wall():
		var tile_id
		for i in get_slide_collision_count():
			@warning_ignore("shadowed_variable")
			var _collision = get_slide_collision(i)
			if _collision.get_collider() is TileMap:
				var tilemap = _collision.get_collider()
				var contact_point = _collision.get_position()
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
	#collision.disabled = false
	var wall_normal = sign(get_wall_normal().x)
	if wall_normal !=0:
		sprite.flip_h = wall_normal != 1
		#sprite.scale.x = wall_normal
	if velocity.y <= 0:
		sprite.frame = 18
	else:
		sprite.frame = 19
	velocity.y = clampf(velocity.y, -max_fall_velocity, max_fall_velocity)
	wall_jump_check(wall_normal)
	apply_wall_slide_gravity(delta)
	move_and_slide()
	wall_detach(delta)

func wall_jump_check(wall_axis):
	if jump_buffer:
		velocity.x = wall_axis*default_max_velocity
		state = "move_state"
		jump(jump_force*partial_jump_multiplier)
		jump_buffer = false
		return
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
	if stats["save_data"]["slopeless"] and stats["current_challenge_level_name"] == "":
		var rand_death_sound = rng.randi_range(1,10000)
		var ty_death_sound = rng.randi_range(1,1000)
		var rand = rng.randi_range(1,18)
		var cat_rand = rng.randi_range(1,20)
		if stats["save_data"]["equiped_armor"] == "purrfallen":
			if rand_death_sound == 42:
				@warning_ignore("narrowing_conversion")
				sounds.play_sfx("extended_meow",randf_range(1.1,1.3),0.3)
			else:
				@warning_ignore("narrowing_conversion")
				sounds.play_sfx("meow_%s"%[str(cat_rand)],randf_range(0.9,1),0.2)
		else:
			if ty_death_sound == 42:
				@warning_ignore("narrowing_conversion")
				sounds.play_sfx("hurt_%s"%[str(19)],randf_range(0.9,1),0)
			else:
				@warning_ignore("narrowing_conversion")
				sounds.play_sfx("hurt_%s"%[str(rand)],randf_range(0.9,1),0)
			if rand_death_sound == 42:
				@warning_ignore("narrowing_conversion")
				sounds.play_sfx("random_scream",randf_range(0.8,1),0)
		@warning_ignore("narrowing_conversion")
		sounds.play_sfx("chain_damage_1",randf_range(0.8,1),0)
		@warning_ignore("narrowing_conversion")
		sounds.play_sfx("chain_damage_2",randf_range(0.9,1.1),0)
		if stats["save_data"]["hard_mode"]:
			stats.reset_run()
			change_scene.emit()
		else:
			respawn.emit()
	else:
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
	if damages.size() > 0:
		return
	damages.append(damage)
	var rand_death_sound = rng.randi_range(1,10000)
	var ty_death_sound = rng.randi_range(1,100)
	var rand = rng.randi_range(1,18)
	var cat_rand = rng.randi_range(1,20)
	if stats["save_data"]["equiped_armor"] == "purrfallen" or stats["save_data"]["equiped_armor"] == "purrfallen_ty":
		if rand_death_sound == 42:
			@warning_ignore("narrowing_conversion")
			sounds.play_sfx("extended_meow",randf_range(1.1,1.3),0.3)
		else:
			@warning_ignore("narrowing_conversion")
			sounds.play_sfx("meow_%s"%[str(cat_rand)],randf_range(0.9,1),0.2)
	else:
		@warning_ignore("narrowing_conversion")
		if ty_death_sound == 42:
			@warning_ignore("narrowing_conversion")
			sounds.play_sfx("hurt_%s"%[str(19)],randf_range(0.9,1),0)
		else:
			@warning_ignore("narrowing_conversion")
			sounds.play_sfx("hurt_%s"%[str(rand)],randf_range(0.9,1),0)
		if rand_death_sound == 42:
			@warning_ignore("narrowing_conversion")
			sounds.play_sfx("random_scream",randf_range(0.8,1),0)
	if damage == 1:
		@warning_ignore("narrowing_conversion")
		sounds.play_sfx("chain_damage_1",randf_range(0.8,1),0)
		@warning_ignore("narrowing_conversion")
		sounds.play_sfx("chain_damage_2",randf_range(0.9,1.1),0)
		add_spike()
		check_death()
	elif damage == 2:
		@warning_ignore("narrowing_conversion")
		sounds.play_sfx("burn_death",randf_range(0.8,1),-10)
		@warning_ignore("narrowing_conversion")
		sounds.play_sfx("liquid_death",randf_range(0.8,1),0)
		add_lava()
		check_death()
	elif damage == 3:
		@warning_ignore("narrowing_conversion")
		sounds.play_sfx("burn_death",randf_range(0.8,1),-5)
		add_explosion()
		check_death()
	elif damage == 4:
		@warning_ignore("narrowing_conversion")
		sounds.play_sfx("chain_damage_1",randf_range(0.8,1),0)
		add_book_death()
		check_death()
	else:
		pass

func add_spike():
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

func add_lava():
	stats["save_data"]["stats"]["Melted"] += 1

func add_explosion():
	stats["save_data"]["stats"]["Exploded"] += 1

func add_book_death():
	stats["save_data"]["stats"]["Booked"] += 1

func set_invincible(_bool):
	invincible = _bool

func check_death():
	if stats.current_challenge_level_name == "":
		apply_space(false)
	#process_mode = Node.PROCESS_MODE_DISABLED
	state = "pause_state"
	var death_timer = get_tree().create_timer(.3)
	var fade_tween = get_tree().create_tween()
	var size_tween = get_tree().create_tween()
	fade_tween.tween_property(sprite,"modulate",Color.DARK_RED,.2)
	size_tween.tween_property(sprite,"scale",Vector2(2,2),.2)
	await death_timer.timeout
	#process_mode = Node.PROCESS_MODE_INHERIT
	damages = []
	state = "move_state"
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
		if bounce < 200:
			@warning_ignore("narrowing_conversion")
			sounds.play_sfx("glass",randf_range(0.8,1.4),-5)
		else:
			@warning_ignore("narrowing_conversion")
			sounds.play_sfx("player_jump",randf_range(0.8,1.4),-5)
		area.hit(1)
		stats["save_data"]["stats"]["Spring Bounced"] += 1

func calculate_stomp_velocity(linear_velocity: Vector2, impulse):
	apply_stretch()
	var out: = linear_velocity
	out.y = -impulse
	return out

func _on_jump_timer_timeout():
	just_jumped = false

func _on_jump_buffer_timer_timeout():
	jump_buffer = false

func paused():
	state = "pause_state"

func credits_roll():
	#collision.call_deferred("set_disabled",true)
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
@warning_ignore("unused_parameter")
func open_state(delta):
	if opening_state:
		opening_state = false
		animation_player.play("get_up")

func change_to_move_state():
	state = "move_state"
	return


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
		#print(interactable.type)
		self.call("open_"+interactable.type)
	elif (event.is_action_pressed("action") or event.is_action_pressed("controller_action") or event.is_action_pressed("pause")) && interactable != null && interactable.type == interacting_type && interacting:
		interacting_type = ""
		close_interactable()
		var timer = get_tree().create_timer(.1)
		await timer.timeout
		interacting = false

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

signal bart_area
func open_bart_area():
	bart_area.emit()

func open_teleporter():
	sounds.play_sfx("tellyin")
	stats.current_challenge_level = interactable.location
	change_scene.emit(interactable.location)

signal knights_monument
func open_knights_monument():
	knights_monument.emit()

signal wardrobe
func open_wardrobe():
	wardrobe.emit()

signal lecturn
func open_lecturn():
	lecturn.emit()

signal lever
func open_lever():
	lever.emit()

signal upper_lever
func open_upper_lever():
	upper_lever.emit()

signal lower_lever
func open_lower_lever():
	lower_lever.emit()

signal hidden_lever
func open_hidden_lever():
	hidden_lever.emit()

signal dlc_lever
func open_dlc_lever():
	dlc_lever.emit()

var air_recovery_orbs = []
func _on_air_recovery_detection_area_entered(area):
	double_jump = true
	air_recovery_orbs.append(area)
	area.used()

func reset_air_recovery_orbs():
	for orb in air_recovery_orbs:
		orb.refresh()
	air_recovery_orbs = []
