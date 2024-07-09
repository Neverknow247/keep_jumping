extends Node2D

const Book = preload("res://items/book.tscn")

@export var direction = 1
var timer_diff = 0

@onready var top = $top
@onready var bottom = $bottom
@onready var book_list = $book_list

var rng = RandomNumberGenerator.new()

func _ready():
	rng.seed = hash("gib_%s" % [direction])

func _on_timer_timeout():
	timer_diff += 1
	var rand_y = rng.randi_range(top.global_position.y,bottom.global_position.y)
	var new_book = Book.instantiate()
	new_book.seed = timer_diff+direction
	new_book.direction = direction
	new_book.global_position = Vector2(top.global_position.x,rand_y)
	book_list.add_child(new_book)
