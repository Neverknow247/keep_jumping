extends ColorRect

var stats = Stats
var cosmetics = preload("res://cosmetic_resources/cosmetics.tres")

@onready var left_button = $CenterContainer/HBoxContainer/left_button
@onready var right_button = $CenterContainer/HBoxContainer/right_button

@onready var armor_sprite = $CenterContainer/HBoxContainer/Control/armor_sprite

var armor_sprite_index = 0
var hat_sprite_index = 0
var cape_sprite_index = 0

func _ready():
	set_armor_index()
	change_armor_sprite()

func focus():
	right_button.grab_focus()

func set_armor_index():
	if stats["save_data"]["equiped_armor"] == "":
		stats["save_data"]["equiped_armor"] = "default"
	for i in cosmetics["armors"].size():
		if stats["save_data"]["equiped_armor"] == cosmetics["armors"][i]["armor_id"]:
			armor_sprite_index = i
			return

func change_armor_sprite():
	armor_sprite.texture = cosmetics["armors"][armor_sprite_index]["armor_texture"]

func change_armor(num):
	for i in cosmetics["armors"].size():
		armor_sprite_index+=num
		if armor_sprite_index == -1 || armor_sprite_index == cosmetics["armors"].size():
			if armor_sprite_index == -1:
				armor_sprite_index = cosmetics["armors"].size()-1
			else:
				armor_sprite_index = 0
		if stats["save_data"]["armors"][cosmetics["armors"][armor_sprite_index]["armor_id"]]:
			stats["save_data"]["equiped_armor"] = cosmetics["armors"][armor_sprite_index]["armor_id"]
			change_armor_sprite()
			stats.changed_sprite.emit()
			return

func _on_left_button_pressed():
	@warning_ignore("narrowing_conversion")
	Sounds.play_sfx("click",randf_range(.8,1.2),-10)
	change_armor(-1)

func _on_right_button_pressed():
	@warning_ignore("narrowing_conversion")
	Sounds.play_sfx("click",randf_range(.8,1.2),-10)
	change_armor(1)
