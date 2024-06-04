extends Node2D

var sounds = Sounds
var stats = Stats

@onready var green = $green

signal popup(text)

func _ready():
	if stats["save_data"]["armors"]["green"]:
		green.queue_free()

@warning_ignore("unused_parameter")
func _on_green_body_entered(body):
	stats["save_data"]["armors"]["green"] = true
	@warning_ignore("narrowing_conversion")
	sounds.play_sfx("pickup", randf_range(0.6,1.4), -10)
	green.queue_free()
	SaveAndLoad.update_save_data()
	popup.emit("Green Training Armor Found")
