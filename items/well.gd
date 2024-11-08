extends StaticBody2D

@onready var tile_map = $well_ground/TileMap

@warning_ignore("unused_parameter")
func _on_well_ground_body_entered(body):
	var tween = get_tree().create_tween()
	tween.tween_property(tile_map,"modulate",Color(1,1,1,0),.25)

@warning_ignore("unused_parameter")
func _on_well_ground_body_exited(body):
	var tween = get_tree().create_tween()
	tween.tween_property(tile_map,"modulate",Color(1,1,1,1),.25)
