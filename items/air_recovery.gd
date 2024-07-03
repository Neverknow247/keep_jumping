extends Area2D

@onready var sprite = $sprite

func _ready():
	var rand = randi_range(0,5)
	sprite.frame = rand
	sprite.frame = rand

func used():
	self.call_deferred("set_monitorable",false)
	sprite.hide()

func refresh():
	self.call_deferred("set_monitorable",true)
	sprite.show()
