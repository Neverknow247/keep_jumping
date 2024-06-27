extends Area2D

@onready var sprite_2d = $Sprite2D

func used():
	self.call_deferred("set_monitorable",false)
	sprite_2d.hide()

func refresh():
	self.call_deferred("set_monitorable",true)
	sprite_2d.show()
