extends Node2D

var steam = GlobalSteam

@onready var wes_level = $wes_level

func _ready():
	if steam.logged_in_id == 76561198283283003 or steam.logged_in_id == 76561198037479165:
		wes_level.unlocked = true
	else:
		wes_level.queue_free()
