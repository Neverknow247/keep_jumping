extends Area2D

var stats = Stats

@export var level_name:String = "level_1"

@onready var akamaru_sprite = $akamaru_sprite
@onready var flag_sprite = $flag_sprite

var mode_string = ""

func _ready():
	set_mode()
	set_sprite()

func set_mode():
	mode_string = ""
	if stats["save_data"]["hard_mode"]:
		mode_string+="_hard"
	else:
		mode_string+="_normal"
	if stats["save_data"]["blind_mode"]:
		mode_string+="_blind"
	mode_string+="_reunions"

func set_sprite():
	if stats["save_data"]["level_data"][level_name][mode_string] > 0:
		akamaru_sprite.hide()
		flag_sprite.show()
	else:
		akamaru_sprite.show()
		flag_sprite.hide()
