extends Node2D
class_name Level

var stats = Stats
var steam = GlobalSteam
var sounds = Sounds
var global_timer = GlobalTimer

@export var color = Color("#f5ad67")
@export var level_music = "music_original"
@export var background_color = Color("#2f2c4a")
@export var level_name = "Level Temp"
@export var level_id = "level_0_0"
@export var unlocked_level = "level_0_0"
@export var spawn_point = Vector2(0,1792)

var level_id_board

var record_time
var pausable= true

@onready var tile_map = $TileMap
@onready var player = $player
@onready var camera_2d = $Camera2D
@onready var camera_limits = $camera_limits
@onready var ui = $ui
@onready var pause_menu = $ui/pause_menu
#@onready var level_finish_menu = $ui/level_finish_menu

var reset_unlocked = true
var run_start = false
var resetting = false
var end_scene = "res://menus/level_finish.tscn"

func _physics_process(delta):
	pass
	#var clicked_cell = tile_map.local_to_map(tile_map.get_local_mouse_position())
	#var clicked_cell = tile_map.local_to_map(player.global_position+Vector2(0,2))
	#var data = tile_map.get_cell_tile_data(0, clicked_cell)
	#if data:
		#print(data)
		##return data.get_custom_data("power")
	#else:
		#print("null")
	#print(tile_map.get_cell_tile_data(0,player.global_position+Vector2(0,2)))

func _ready():
	set_up_steam()
	player.tile_map = tile_map
	set_camera_limits()
	camera_2d.drag_horizontal_enabled = true
	#camera_2d.drag_vertical_enabled = true
	camera_2d.drag_left_margin = .1
	camera_2d.drag_top_margin = .1
	camera_2d.drag_right_margin = .1
	camera_2d.drag_bottom_margin = .1
	stats.ground_color = color
	get_tree().paused = false 
	randomize()
	#pause_menu.connect("resetting",disable_go)
	SaveAndLoad.update_save_data()
	sounds.play_music(level_music)
	$parallax_background/background/background.color = background_color
	ui.enter_transition()
	global_timer.time = 0
	SaveAndLoad.update_save_data()

func _input(event):
	if event.is_action_pressed("pause"):
		if pausable:
			pause_menu.pause()
		pausable = !pausable
	if event.is_action_pressed("reset_level") && reset_unlocked:
		return
		disable_go()
		#ui.exit_transition()
		get_tree().paused = true
		await get_tree().create_timer(stats.transition_time).timeout
		get_tree().reload_current_scene()

func set_up_steam():
	steam.level_id_board = level_id
	Steam.findLeaderboard(level_id)

func set_camera_limits():
	camera_2d.limit_left = camera_limits.global_position.x
	camera_2d.limit_right = camera_limits.global_position.x+camera_limits.size.x
	camera_2d.limit_top = camera_limits.global_position.y
	camera_2d.limit_bottom = camera_limits.global_position.y+camera_limits.size.y

func disable_go():
	resetting  = true

func start_timer():
	global_timer.timer_on = true

func _on_start_zone_start_timer():
	run_start = true
	@warning_ignore("narrowing_conversion")
	sounds.play_sfx("bark_once",randf_range(0.9,1.2), -25)
	start_timer()
	stats["save_data"]["stats"]["Towers Attempted"] += 1
	SaveAndLoad.update_save_data()
	check_modes()

func check_modes():
	if stats["game_mode"] == "hard":
		$checkpoints.queue_free()
	if stats["blind_mode"]:
		print("low vision")

func change_scene(new_scene):
	get_tree().change_scene_to_file(new_scene)

func _on_player_respawn():
	ui.exit_transition()
	get_tree().paused = true
	await get_tree().create_timer(stats.transition_time).timeout
	player.velocity = Vector2.ZERO
	player.position = spawn_point
	player.invincible = false
	camera_2d.position_smoothing_enabled = false
	camera_2d.position = spawn_point
	get_tree().paused = false
	await get_tree().create_timer(.1).timeout
	ui.enter_transition()
	camera_2d.position_smoothing_enabled = true

func _on_checkpoint_activate_checkpoint(respawn_position,checkpoint):
	for point in $checkpoints.get_children():
		point.active = false
		point.animation_player.play("RESET")
	checkpoint.active = true
	spawn_point = respawn_position

func _on_finish_body_entered(body):
	#sounds.play_sfx("")
	global_timer.timer_on = false
	print("cut scene")
	var new_best = await update_score()
	get_tree().call_deferred("change_scene_to_file",end_scene)

func update_score():
	var new_best = false
	if global_timer.time < stats["save_data"]["level_data"][level_id]["time"]:
		stats["save_data"]["level_data"][level_id]["time"] = global_timer.time
		new_best = true
	SaveAndLoad.update_save_data()
	var modified_time = global_timer.time*1000
	Steam.uploadLeaderboardScore(modified_time)
	return new_best




