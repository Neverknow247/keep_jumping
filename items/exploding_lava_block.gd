extends StaticBody2D

@onready var light = $light
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var hit_box = $hit_box

var explosion_particle = preload("res://particles/explosion_particle.tscn")

func _ready():
	animated_sprite_2d.play("default")

@warning_ignore("unused_parameter")
func _on_player_sense_body_entered(body):
	if animated_sprite_2d.animation == "play":
		return
	else:
		animated_sprite_2d.play("play")
		var tween = get_tree().create_tween()
		tween.tween_property(light,"energy",1,.5)
		await animated_sprite_2d.animation_finished
		explode()

func explode():
	var particle = explosion_particle.instantiate()
	self.add_child(particle)
	particle.global_position = global_position
	particle.emitting = true
	hit_box.call_deferred("set_monitoring",true)
	await get_tree().create_timer(.3).timeout
	hit_box.call_deferred("set_monitoring",false)
	animated_sprite_2d.play("default")
	light.energy = 0
