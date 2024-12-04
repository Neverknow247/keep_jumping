extends Node
class_name All_Rooms

var stats = Stats
var rng = stats.rng

var rooms = [
	#preload("res://levels/other_levels/sir_downwell/rooms/floor_1/room_1_0.tscn"),
	preload("res://levels/other_levels/sir_downwell/rooms/floor_1/room_1_1.tscn"),
	preload("res://levels/other_levels/sir_downwell/rooms/floor_1/room_1_2.tscn"),
	preload("res://levels/other_levels/sir_downwell/rooms/floor_1/room_1_3.tscn"),
	preload("res://levels/other_levels/sir_downwell/rooms/floor_1/room_1_4.tscn"),
	preload("res://levels/other_levels/sir_downwell/rooms/floor_1/room_1_5.tscn"),
	preload("res://levels/other_levels/sir_downwell/rooms/floor_1/room_1_6.tscn"),
	preload("res://levels/other_levels/sir_downwell/rooms/floor_1/room_1_7.tscn"),
	preload("res://levels/other_levels/sir_downwell/rooms/floor_1/room_1_8.tscn"),
	preload("res://levels/other_levels/sir_downwell/rooms/floor_1/room_1_9.tscn"),
	preload("res://levels/other_levels/sir_downwell/rooms/floor_1/room_1_10.tscn"),
	preload("res://levels/other_levels/sir_downwell/rooms/floor_1/room_1_11.tscn"),
	preload("res://levels/other_levels/sir_downwell/rooms/floor_1/room_1_12.tscn"),
]
var starting_rooms = [
	preload("res://levels/other_levels/sir_downwell/rooms/starting/room_s_1.tscn"),
	#preload("res://levels/other_levels/sir_downwell/rooms/starting/room_s_2.tscn"),
]
var exit_rooms = [
	preload("res://levels/other_levels/sir_downwell/rooms/exit/room_e_1.tscn"),
	#preload("res://levels/other_levels/sir_downwell/rooms/exit/room_e_2.tscn"),
]
#var merchant_rooms = [
	#preload("res://levels/rooms/merchant/room_m_1.tscn"),
#]
#var secret_rooms = []
#var fake_room_247 = preload("res://levels/rooms/secret/room_0_247_fake.tscn")
#var room_247 = preload("res://levels/rooms/secret/room_0_247.tscn")
#
#var boss_rooms = [
	#preload("res://levels/boss_rooms/spider_boss_room.tscn"),
#]

func choose_room(type = ""):
	if type == "starting":
		var s_room = rng.randi_range(0,starting_rooms.size()-1)
		return starting_rooms[s_room]
	elif type == "exit":
		var e_room = rng.randi_range(0,exit_rooms.size()-1)
		return exit_rooms[e_room]
	#elif stats.boss:
		#var b_room = rng.randi_range(0,boss_rooms.size()-1)
		#return boss_rooms[b_room]
	#elif type == "merchant_room":
		#var m_room = rng.randi_range(0,merchant_rooms.size()-1)
		#return merchant_rooms[m_room]
	#var room_247_chance = rng.randi_range(1,1991)
	#if room_247_chance <= 8:
		#return fake_room_247
	#elif room_247_chance == 1991:
		##print("1991")
		##stats.secret = true
		#return room_247
	#else:
		#var room = rng.randi_range(0,rooms.size()-1)
		#return rooms[room]
	var room = rng.randi_range(0,rooms.size()-1)
	return rooms[room]
