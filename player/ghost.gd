extends Node2D

var stats = Stats
var cosmetics = preload("res://cosmetic_resources/cosmetics.tres")

@onready var sprite = $sprite
@onready var hat_sprite = $hat_sprite
@onready var ear_sprite = $hat_sprite/ear_sprite

func set_dog_sprites(texture):
	var dog_index
	for i in cosmetics["dogs"].size():
		if texture == cosmetics["dogs"][i]["dog_name"]:
			dog_index = i
	
	sprite.texture = cosmetics["dogs"][dog_index]["dog_texture"]
	ear_sprite.texture = cosmetics["dogs"][dog_index]["ear_texture"]

func set_hat_sprites(texture):
	var hat_index
	for i in cosmetics["hats"].size():
		if texture == cosmetics["hats"][i]["hat_name"]:
			hat_index = i
	
	hat_sprite.texture = cosmetics["hats"][hat_index]["hat_texture"]
	if cosmetics["hats"][hat_index].ear_sprite_visible:
		ear_sprite.visible = true
	else:
		ear_sprite.visible = false
