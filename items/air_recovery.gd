extends Area2D

@onready var sprite = $sprite

func used():
	self.call_deferred("set_monitorable",false)
	sprite.hide()

func refresh():
	self.call_deferred("set_monitorable",true)
	sprite.show()
