extends Node2D

var stats = Stats
var sounds = Sounds

signal popup(text)

@onready var white_rose = $white_rose
@onready var basket = $basket
@onready var towel = $towel

func _ready():
	if stats["save_data"]["items"]["white_rose"]:
		white_rose.queue_free()
	if stats["save_data"]["items"]["basket"]:
		basket.queue_free()
	if stats["save_data"]["items"]["towel"]:
		towel.queue_free()

signal check_picnic
@warning_ignore("unused_parameter")
func _on_white_rose_body_entered(body):
	GlobalSteam.setAchievement("ACH_ROSE")
	stats["save_data"]["items"]["white_rose"] = true
	@warning_ignore("narrowing_conversion")
	sounds.play_sfx("pickup", randf_range(0.6,1.4), -10)
	white_rose.queue_free()
	SaveAndLoad.update_save_data()
	popup.emit("Found the White Rose")
	check_picnic.emit()

@warning_ignore("unused_parameter")
func _on_basket_body_entered(body):
	GlobalSteam.setAchievement("ACH_BASKET")
	stats["save_data"]["items"]["basket"] = true
	@warning_ignore("narrowing_conversion")
	sounds.play_sfx("pickup", randf_range(0.6,1.4), -10)
	basket.queue_free()
	SaveAndLoad.update_save_data()
	popup.emit("Found your Basket")
	check_picnic.emit()

@warning_ignore("unused_parameter")
func _on_towel_body_entered(body):
	GlobalSteam.setAchievement("ACH_TOWEL")
	stats["save_data"]["items"]["towel"] = true
	@warning_ignore("narrowing_conversion")
	sounds.play_sfx("pickup", randf_range(0.6,1.4), -10)
	towel.queue_free()
	SaveAndLoad.update_save_data()
	popup.emit("Found your Towel")
	check_picnic.emit()
