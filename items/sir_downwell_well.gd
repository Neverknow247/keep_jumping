extends StaticBody2D

var stats = Stats

@onready var sprite_2d = $Sprite2D
@onready var collision_shape_2d = $CollisionShape2D
@onready var tile_map = $well_ground/TileMap
@onready var entry_door = $entry_door

func _ready():
	if stats["save_data"]["sir_downwell_unlocked"]:
		sprite_2d.frame = 2
		collision_shape_2d.set_deferred("disabled",false)
		entry_door.queue_free()

@warning_ignore("unused_parameter")
func _on_well_ground_body_entered(body):
	var tween = get_tree().create_tween()
	tween.tween_property(tile_map,"modulate",Color(1,1,1,0),.25)

@warning_ignore("unused_parameter")
func _on_well_ground_body_exited(body):
	var tween = get_tree().create_tween()
	tween.tween_property(tile_map,"modulate",Color(1,1,1,1),.25)
