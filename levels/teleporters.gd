extends Node2D

var stats = Stats

@onready var adept_ascent = $adept_ascent
@onready var tiny_tower = $tiny_tower
@onready var peril_pathway = $peril_pathway
@onready var enigma_escape = $enigma_escape
@onready var s_3 = $"S-3"
@onready var library_teleporter = $library_teleporter
@onready var arcade_teleport_1 = $arcade_teleport1
@onready var arcade_teleport_2 = $arcade_teleport2
@onready var arcade_teleport_3 = $arcade_teleport3
@onready var arcade_teleport_4 = $arcade_teleport4
@onready var arcade_teleport_5 = $arcade_teleport5
@onready var crystal_ball_teleporter = $crystal_ball_teleporter
@onready var clock_teleporter = $clock_teleporter

func _ready():
	unlock_training_teleporters()
	unlock_other_teleporters()
	unlock_arcades()

func unlock_training_teleporters():
	if !stats["save_data"]["challenge_data"]["challenge_6"]["_normal_reunions"] > 0:
		adept_ascent.unlocked = false
		adept_ascent.visible = false
	if !stats["save_data"]["challenge_data"]["challenge_7"]["_normal_reunions"] > 0:
		tiny_tower.unlocked = false
		tiny_tower.visible = false
	if !stats["save_data"]["challenge_data"]["challenge_0"]["_normal_reunions"] > 0:
		peril_pathway.unlocked = false
		peril_pathway.visible = false
	if !stats["save_data"]["challenge_data"]["challenge_3"]["_normal_reunions"] > 0:
		enigma_escape.unlocked = false
		enigma_escape.visible = false

func unlock_other_teleporters():
	if !stats["save_data"]["items"]["spikes"]:
		s_3.unlocked = false
		s_3.visible = false
	if !stats["save_data"]["items"]["library"]:
		library_teleporter.unlocked = false
		library_teleporter.visible = false
	if !stats["save_data"]["items"]["crystal_ball"]:
		crystal_ball_teleporter.unlocked = false
		crystal_ball_teleporter.visible = false
	if !stats["save_data"]["items"]["clock"]:
		clock_teleporter.unlocked = false
		clock_teleporter.visible = false

func unlock_arcades():
	$arcade_teleport1/AnimatedSprite2D.hide()
	$arcade_teleport1/AnimatedSprite2D2.hide()
	$arcade_teleport2/AnimatedSprite2D.hide()
	$arcade_teleport2/AnimatedSprite2D2.hide()
	$arcade_teleport3/AnimatedSprite2D.hide()
	$arcade_teleport3/AnimatedSprite2D2.hide()
	$arcade_teleport4/AnimatedSprite2D.hide()
	$arcade_teleport4/AnimatedSprite2D2.hide()
	$arcade_teleport5/AnimatedSprite2D.hide()
	$arcade_teleport5/AnimatedSprite2D2.hide()
	if !stats["save_data"]["items"]["arcade_1"]:
		arcade_teleport_1.visible = false
	if !stats["save_data"]["items"]["arcade_2"]:
		arcade_teleport_2.visible = false
	if !stats["save_data"]["items"]["arcade_3"]:
		arcade_teleport_3.visible = false
	if !stats["save_data"]["items"]["arcade_4"]:
		arcade_teleport_4.visible = false
	if !stats["save_data"]["items"]["arcade_5"]:
		arcade_teleport_5.visible = false
