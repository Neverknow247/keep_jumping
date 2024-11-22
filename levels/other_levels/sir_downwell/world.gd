extends Node2D

var stats = Stats
var steam = GlobalSteam

var all_rooms = All_Rooms.new()
#var all_enemies = All_Enemies.new()

@export var level_id = "challenge_1"
@export var level_name = "Challenge Name"

@onready var player = $player_downwell
@onready var rooms = $rooms
@onready var main_cam = $Camera2D
@onready var ui = $ui_sir_downwell
@onready var pause_menu = $ui_sir_downwell/pause_menu
@onready var level_label = $ui_sir_downwell/level_label

var offset = Vector2(28,16)
var tile_set = 16
var generator = Generator.new()
var dungeon = []
var current_room

var rooms_number = 10
var merchant_check = 0
var merchant_chosen = false

var level_id_board
var mode_string = ""

var pausable = true
func _input(event):
	if event.is_action_pressed("pause") and !player.interacting:
		if pausable:
			pause_menu.pause()
		pausable = !pausable
	if event is InputEventMouseMotion:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _ready():
	#print(stats.rng.seed)
	#Sounds.play_music("dungeon_1")
	#if stats.cheat == "bossonly":stats.boss = true 
	#elif stats.cheat == "noboss": stats.boss = false
	#if stats.boss:
		#generator.generate(3)
		#dungeon = generator.dungeon_detailed
		#generate_dungeon()
	#else:
	#stats.floor_number += 1
	#rooms_number = floor(3.4*stats.floor_number)+stats.rng.randi_range(6,8)
	set_up_label()
	set_up_mode()
	set_up_steam()
	rooms_number = 7
	generator.generate(rooms_number)
	dungeon = generator.dungeon_detailed
	generate_dungeon()
	get_tree().paused = false 
	ui.enter_transition()

@warning_ignore("unused_parameter")
func _process(delta):
	if (Input.is_action_pressed("reset_level") and Input.is_action_pressed("reset_control")) || (Input.is_action_pressed("controller_reset_level") and Input.is_action_pressed("controller_reset_control")):
		SirDownwellStats.reset_sir_downwell()
		change_scene()

func set_up_label():
	level_label.text = level_name+" | Level: "+var_to_str(SirDownwellStats["level"])
	stats.current_challenge_level_name = level_name

func set_up_mode():
	level_id_board = level_id
	if stats["save_data"]["hard_mode"]:
		mode_string+="_hard"
		#$checkpoints.hide()
	else:
		mode_string+="_normal"
		#$checkpoints.show()
	level_id_board+=mode_string

func set_up_steam():
	steam.level_id_board = level_id_board
	Steam.findLeaderboard(level_id_board)

func _on_level_door_travel_to(level):
	$game_ui/pause_menu.can_pause = false
	player.hide()
	player.change_to_pause()
	stats.boss = !stats.boss
	main_cam.fade("out")
	await get_tree().create_timer(1).timeout
	get_tree().change_scene_to_file(level)

func generate_dungeon():
	for dungeon_room in dungeon:
		merchant_check += 1
		var room
		if dungeon_room["starting_room"]:
			room = all_rooms.choose_room("starting").instantiate()
		elif dungeon_room["exit_room"]:
			room = all_rooms.choose_room("exit").instantiate()
		else:
			var merchant_chance = stats.rng.randi_range(3,rooms_number-2)
			if !merchant_chosen and merchant_check>(rooms_number-2) || !merchant_chosen and merchant_chance == merchant_check:
				room = all_rooms.choose_room("merchant_room").instantiate()
				merchant_chosen = true
			else:
				room = all_rooms.choose_room().instantiate()
		rooms.add_child(room)
		room.position = dungeon_room["location"]*(offset*tile_set)
		#var enemy_types = summon_enemies(dungeon_room,room)
		#summon_gems(room, enemy_types)
		#room.get_node("player_sensor").connect("body_entered",_on_change_room.bind(room,dungeon_room))
		#set_doors(dungeon_room,room)
		#if dungeon_room["starting_room"]:
			#player.position = (dungeon_room["location"]*(offset*tile_set))+Vector2(224,128)
			#main_cam.position = room.get_node("cam_position").position
			#main_cam.enabled = true
		#if dungeon_room["exit_room"]:
			#room.get_node("doors").get_node("exit").travel_to.connect(_on_level_door_travel_to)
		#if room.is_in_group("boss_room"):
			##summon_gems(room,[1,2,3,4,5])
			#if room.get_node("boss").get_child(0).is_in_group("boss"):
				#var boss = room.get_node("boss").get_child(0)
				#boss.connect("die",check_open_room_doors.bind(dungeon_room,room))
				#boss.target = player
				#game_ui.get_node("boss_health_meter").set_up_bar(boss.character_stats.max_health)
				#boss.character_stats.health_changed.connect(game_ui.get_node("boss_health_meter")._on_change_health)
				#room.get_node("player_sensor").connect("body_entered",game_ui.get_node("boss_health_meter").reveal_bar.bind(room,dungeon_room))

#func summon_enemies(dungeon_room,room):
	#var enemy_types = []
	#for enemy_position in room.get_node("enemy_spawn_positions").get_children():
		#if stats.rng.randi_range(1,3)<=2:
			#var enemy_data = all_enemies.instance_enemy()
			#var new_enemy = Utils.instantiate_scene_on_node(enemy_data["enemy"],enemy_position.global_position,room.get_node("enemies"))
			#new_enemy.connect("die",check_open_room_doors.bind(dungeon_room,room))
			#var upgrade_gem_reward_num = stats.rng.randi_range(-1,2)
			#var coin_reward_num = stats.rng.randi_range(-1,2)
			#var heal_reward = stats.rng.randi_range(-23,1)
			#new_enemy.upgrade_gem_reward = upgrade_gem_reward_num
			#new_enemy.coin_reward = coin_reward_num
			#new_enemy.heal_reward = heal_reward
			#if !enemy_data["type"] in enemy_types:
				#enemy_types.append(enemy_data["type"])
	#return enemy_types

#func summon_gems(room,enemy_types):
	#var gem_positions = room.get_node("gem_spawn_positions").get_children()
	#gem_positions = Utils.array_shuffle(gem_positions)
	#for gem_position in gem_positions:
		#if enemy_types.size() > 0:
			#var new_gem = Utils.instantiate_scene_on_node(gem_scene,gem_position.global_position,room.get_node("gems"))
			#new_gem.gem_type = enemy_types[0]
			#new_gem.get_node("sprite").texture = new_gem.sprites_array[enemy_types[0]]
			#new_gem.get_node("light").color = Color(Stats.color_array[enemy_types[0]])
			#enemy_types.pop_front()

#func set_doors(dungeon_room,room):
	#for i in generator.door_names.size():
		#if dungeon_room[generator.door_names[i]]:
			#for tile in generator.door_locations[i]:
				#room.get_node("TileMap").set_cell(1,tile,-1)

@warning_ignore("unused_parameter")
func _on_change_room(body,room,dungeon_room):
	var new_cam_pos = room.get_node("player_sensor").global_position
	var tween = get_tree().create_tween()
	tween.tween_property(main_cam,"position",new_cam_pos,2).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)
	current_room = room
	check_room_doors(room,dungeon_room)

func check_room_doors(room,dungeon_room):
	if room.get_node("enemies").get_children().size() > 0 || room.get_node("boss").get_children().size():
		for i in generator.door_names.size():
			if dungeon_room[generator.door_names[i]]:
				room.get_node("TileMap").set_cells_terrain_connect(1,generator.door_locations[i],1,0)

func check_open_room_doors(dungeon_room,room):
	await get_tree().create_timer(.25).timeout
	if room.get_node("enemies").get_children().size() == 0:
		for i in generator.door_names.size():
			if dungeon_room[generator.door_names[i]]:
				for tile in generator.door_locations[i]:
					room.get_node("TileMap").set_cell(1,tile,-1)

func change_scene(new_scene = null):
	ui.exit_transition()
	get_tree().paused = true
	await get_tree().create_timer(stats.transition_time).timeout
	if new_scene:
		get_tree().call_deferred("change_scene_to_file",new_scene)
	else:
		get_tree().call_deferred("reload_current_scene")
