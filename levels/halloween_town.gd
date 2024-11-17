extends Node2D

var stats = Stats

@onready var halloween_town_teleporter = $halloween_town_teleporter

func _ready():
	unlock_halloween()

func unlock_halloween():
	if !stats["save_data"]["eggs"]["halloween_town"]:
		halloween_town_teleporter.unlocked = false
		halloween_town_teleporter.visible = false
