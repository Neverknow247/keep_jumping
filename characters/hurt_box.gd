extends Area2D

signal hit(damage)

@warning_ignore("unused_parameter")
func _on_body_entered(body):
	call_deferred("spike_tiles_hit")

func spike_tiles_hit():
	hit.emit(1)

#new
signal hurt(hitbox, damage)

var is_invincible = false :
	set(value):
		is_invincible = value
		disable.call_deferred(value)

func take_hit(hitbox, damage):
	if is_invincible: return
	hurt.emit(hitbox, damage)

func disable(value):
	for child in get_children():
		if child is CollisionShape2D or child is CollisionPolygon2D:
			child.disabled = value
