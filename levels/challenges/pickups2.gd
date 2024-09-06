extends Node2D

var sounds = Sounds
var stats = Stats

@export var item_name: String
@export var popup_text: String

@onready var item = $item

signal popup(text)

func _ready():
	if item_name != "":
		if stats["save_data"]["items"][item_name]:
			item.queue_free()

@warning_ignore("unused_parameter")
func _on_item_body_entered(body):
	stats["save_data"]["items"][item_name] = true
	@warning_ignore("narrowing_conversion")
	sounds.play_sfx("pickup", randf_range(0.6,1.4), -10)
	item.queue_free()
	SaveAndLoad.update_save_data()
	popup.emit(popup_text)

