extends Node2D

var sounds = Sounds
var stats = Stats

@export var cosmetic_name: String
@export var popup_text: String

@onready var cosmetic = $cosmetic

signal popup(text)

func _ready():
	if cosmetic_name != "":
		if stats["save_data"]["armors"][cosmetic_name]:
			cosmetic.queue_free()

@warning_ignore("unused_parameter")
func _on_cosmetic_body_entered(body):
	stats["save_data"]["armors"][cosmetic_name] = true
	@warning_ignore("narrowing_conversion")
	sounds.play_sfx("pickup", randf_range(0.6,1.4), -10)
	cosmetic.queue_free()
	SaveAndLoad.update_save_data()
	popup.emit(popup_text)
