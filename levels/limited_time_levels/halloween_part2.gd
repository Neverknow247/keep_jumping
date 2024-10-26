extends Node2D

@onready var tile_map = $TileMap

signal mage_progression

func _on_area_2d_body_entered(body):
	var tween = get_tree().create_tween()
	tween.tween_property(tile_map,"modulate",Color(1,1,1,0),.25)
	body.state = "slope_state"
	body.sprite.texture = preload("res://assets/art/characters/player/player_ghost-sheet.png")
	mage_progression.emit()
	#Stats["save_data"]["equiped_armor"]["ghost"]
