extends Node2D

var sounds = Sounds

var found_hat = false
var found_mask = false
var found_clothes = false

@onready var hat = $hat
@onready var mask = $mask
@onready var clothes = $clothes
@onready var door = $door

signal popup(popup_text)
signal finish_kid_zombie_quest

func _on_hat_body_entered(body):
	@warning_ignore("narrowing_conversion")
	sounds.play_sfx("pickup", randf_range(0.6,1.4), -10)
	popup.emit("Found zombie brat's hat")
	found_hat = true
	hat.queue_free()
	check_door()

func _on_mask_body_entered(body):
	@warning_ignore("narrowing_conversion")
	sounds.play_sfx("pickup", randf_range(0.6,1.4), -10)
	popup.emit("Found zombie brat's mask")
	found_mask = true
	mask.queue_free()
	check_door()

func _on_clothes_body_entered(body):
	@warning_ignore("narrowing_conversion")
	sounds.play_sfx("pickup", randf_range(0.6,1.4), -10)
	popup.emit("Found zombie brat's clothes")
	found_clothes = true
	clothes.queue_free()
	check_door()

func check_door():
	if found_hat and found_mask and found_clothes:
		finish_kid_zombie_quest.emit()
		door.queue_free()
