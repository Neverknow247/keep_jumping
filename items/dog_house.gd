extends Interactable_script

var cosmetics = preload("res://cosmetic_resources/cosmetics.tres")

@warning_ignore("unused_signal")
signal finish_pet

@onready var dog_sprite = $Sprite2D/dog_sprite
@onready var animation_player = $AnimationPlayer

func _ready():
	#set_texture()
	if stats.calc_total_reunions() > 0:
		unlocked = true
		$Sprite2D/dog_sprite.show()
	else:
		unlocked = false
		$Sprite2D/dog_sprite.hide()

func set_texture():
	var armor_index
	for i in cosmetics["armors"].size():
		if stats["save_data"]["equiped_armor"] == cosmetics["armors"][i]["armor_id"]:
			armor_index = i
	dog_sprite.texture = cosmetics["armors"][armor_index]["dog_texture"]
