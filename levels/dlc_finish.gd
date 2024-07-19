extends Area2D

var stats = Stats
var sounds = Sounds

@export var level_name:String = "level_2"

@onready var gem_sprite = $gem_sprite
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
		gem_sprite.hide()
		flag_sprite.show()
	else:
		gem_sprite.show()
		flag_sprite.hide()

func play_ending():
	$gem_sprite/AnimationPlayer.play("finish")

@warning_ignore("unused_parameter")
func _on_body_entered(body):
	call_deferred("set_monitoring",false)
	play_ending()
