extends Control

var rng = RandomNumberGenerator.new()

@onready var dog = $dog
@onready var ear = $dog/ear

@export var dog_x : float = 288
@export var dog_y : float = -96

func _ready():
	rng.randomize()

@warning_ignore("unused_parameter")
func _process(delta):
	dog.position.x = dog_x
	dog.position.y = dog_y
