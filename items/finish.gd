extends Area2D

var stats = Stats
var sounds = Sounds
var cosmetics = preload("res://cosmetic_resources/cosmetics.tres")

@export var level_name:String = "level_1"

@onready var akamaru_sprite = $akamaru_sprite
@onready var flag_sprite = $flag_sprite

var mode_string = ""

func _ready():
	set_mode()
	#set_texture()
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

func set_texture():
	var armor_index
	for i in cosmetics["armors"].size():
		if stats["save_data"]["equiped_armor"] == cosmetics["armors"][i]["armor_id"]:
			armor_index = i
	#akamaru_sprite.texture = cosmetics["armors"][armor_index]["dog_texture"]

func set_sprite():
	if stats["save_data"]["level_data"][level_name][mode_string] > 0:
		akamaru_sprite.hide()
		flag_sprite.show()
	else:
		akamaru_sprite.show()
		flag_sprite.hide()

func play_ending():
	@warning_ignore("narrowing_conversion")
	sounds.play_sfx("bark_twice", randf_range(0.7,1.2), -25)
	if stats["save_data"]["level_data"][level_name][mode_string] > 0:
		pass
	else:
		$akamaru_sprite/AnimationPlayer.play("pet")

@warning_ignore("unused_parameter")
func _on_body_entered(body):
	call_deferred("set_monitoring",false)
	play_ending()
