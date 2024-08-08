extends Area2D

var sounds = Sounds

@onready var sprite = $sprite

func _ready():
	var rand = randi_range(0,5)
	sprite.frame = rand
	#sprite.frame = rand

func used():
	@warning_ignore("narrowing_conversion")
	sounds.play_sfx("air_recovery",randf_range(0.8,1),-10)
	self.call_deferred("set_monitorable",false)
	sprite.hide()

func refresh():
	self.call_deferred("set_monitorable",true)
	sprite.show()
