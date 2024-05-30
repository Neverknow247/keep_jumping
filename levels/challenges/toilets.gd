extends Node2D

@onready var all_toilets = $all_toilets
@onready var broken_pieces = $broken_pieces
@onready var door = $door

var toilet_pieces = [
	preload("res://items/broken_toilet_1.tscn"),
	preload("res://items/broken_toilet_2.tscn"),
	preload("res://items/broken_toilet_3.tscn"),
	]

func _process(delta):
	check_toilets()

func check_toilets():
	if all_toilets.get_child_count() == 0:
		open_door()

func open_door():
	door.open_door()

func _on_breakable_toilet_break_toilet(pos):
	for piece in toilet_pieces:
		var single_piece = piece.instantiate()
		broken_pieces.call_deferred("add_child",single_piece)
		single_piece.global_position = pos+Vector2(randi_range(-3,3),randi_range(0,0))
