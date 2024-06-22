extends Node2D

var stats = Stats

@onready var adept_ascent = $adept_ascent
@onready var tiny_tower = $tiny_tower
@onready var peril_pathway = $peril_pathway
@onready var enigma_escape = $enigma_escape
@onready var s_3 = $"S-3"

func _ready():
	unlock_training_teleporters()
	unlock_other_teleporters()

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
