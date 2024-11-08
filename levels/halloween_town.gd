extends Node2D

var stats = Stats

@onready var halloween_p_1 = $halloween_p1
@onready var halloween_p_2 = $halloween_p2
@onready var halloween_p_3 = $halloween_p3
@onready var halloween_p_4 = $halloween_p4
@onready var halloween_town_teleporter = $halloween_town_teleporter

func _ready():
	unlock_halloween()


func unlock_halloween():
	if !stats["save_data"]["challenge_data"]["challenge_35"]["_normal_reunions"] > 0:
		halloween_p_2.unlocked = false
		halloween_p_2.visible = false
	if !stats["save_data"]["challenge_data"]["challenge_36"]["_normal_reunions"] > 0:
		halloween_p_3.unlocked = false
		halloween_p_3.visible = false
	if !stats["save_data"]["challenge_data"]["challenge_37"]["_normal_reunions"] > 0:
		halloween_p_4.unlocked = false
		halloween_p_4.visible = false
	if !stats["save_data"]["eggs"]["halloween_town"]:
		halloween_town_teleporter.unlocked = false
		halloween_town_teleporter.visible = false
