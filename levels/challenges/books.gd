extends Node2D

const Book = preload("res://items/book.tscn")

@export var direction = 1

@onready var top = $top
@onready var bottom = $bottom
@onready var book_list = $book_list

func _on_timer_timeout():
	var rand_y = randi_range(top.global_position.y,bottom.global_position.y)
	var new_book = Book.instantiate()
	new_book.direction = direction
	new_book.global_position = Vector2(top.global_position.x,rand_y)
	book_list.add_child(new_book)
