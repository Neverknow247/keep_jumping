extends Node2D

var sounds = Sounds

@onready var key_1 = $key_1
@onready var key_2 = $key_2
@onready var key_3 = $key_3
@onready var key_4 = $key_4

var key_order = []
var correct_order = ["key_1","key_2","key_3","key_4"]

signal door_open

func check_door():
	print(key_order,correct_order)
	if key_order == correct_order:
		door_open.emit()

func _on_key_1_body_entered(body):
	key_order.append("key_1")
	@warning_ignore("narrowing_conversion")
	sounds.play_sfx("pickup", randf_range(0.6,1.4), -10)
	key_1.queue_free()
	check_door()

func _on_key_2_body_entered(body):
	key_order.append("key_2")
	@warning_ignore("narrowing_conversion")
	sounds.play_sfx("pickup", randf_range(0.6,1.4), -10)
	key_2.queue_free()
	check_door()

func _on_key_3_body_entered(body):
	key_order.append("key_3")
	@warning_ignore("narrowing_conversion")
	sounds.play_sfx("pickup", randf_range(0.6,1.4), -10)
	key_3.queue_free()
	check_door()

func _on_key_4_body_entered(body):
	key_order.append("key_4")
	@warning_ignore("narrowing_conversion")
	sounds.play_sfx("pickup", randf_range(0.6,1.4), -10)
	key_4.queue_free()
	check_door()
