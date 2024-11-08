extends Area2D

var stats = Stats
var sounds = Sounds

signal popup(text)

@export var bone_number = "one"

func _ready():
	if stats["save_data"]["eggs"]["halloween_bones"][bone_number]:
		queue_free()

@warning_ignore("unused_parameter")
func _on_body_entered(body):
	popup.emit("Bone "+bone_number+" found!")
	@warning_ignore("narrowing_conversion")
	sounds.play_sfx("pickup", randf_range(0.6,1.4), -10)
	stats["save_data"]["eggs"]["halloween_bones"][bone_number] = true
	SaveAndLoad.update_save_data()
	queue_free()
