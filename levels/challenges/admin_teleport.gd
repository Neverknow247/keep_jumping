extends Node2D

var stats = Stats

@export var player : CharacterBody2D
@export var checkpoints : Node2D

var checkpoints_num
var location = 0

func _ready():
	checkpoints_num = checkpoints.get_children().size()

func _input(event):
	if event.is_action_pressed("admin_tele_back"):
		teleport(-1)
	if event.is_action_pressed("admin_tele_forward"):
		teleport(1)

func teleport(num):
	location+=num
	if location<0:
		location = checkpoints_num-1
	elif location >= checkpoints_num:
		location = 0
	player.global_position = checkpoints.get_children()[location].global_position
