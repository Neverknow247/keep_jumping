extends Area2D

@export var damage = 1

func _on_area_entered(area):
	if area.is_in_group("player_hurt_box"):
		area.hit.emit(damage)
