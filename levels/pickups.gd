extends Node2D

var stats = Stats
var sounds = Sounds

signal popup(text)

@onready var white_rose = $white_rose
@onready var basket = $basket
@onready var towel = $towel
@onready var wes = $wes
@onready var purple_armor_unlock = $purple_armor_unlock
@onready var brown_armor_unlock = $brown_armor_unlock
@onready var red_armor_unlock = $red_armor_unlock
@onready var yellow_armor_unlock = $yellow_armor_unlock
@onready var frog = $frog
@onready var space_skin = $space_skin
@onready var flag = $flag
@onready var belt = $belt
@onready var sombrero = $sombrero

func _ready():
	if stats["save_data"]["items"]["white_rose"]:
		white_rose.queue_free()
	if stats["save_data"]["items"]["basket"]:
		basket.queue_free()
	if stats["save_data"]["items"]["towel"]:
		towel.queue_free()
	if stats["save_data"]["armors"]["wes"]:
		wes.queue_free()
	if stats["save_data"]["armors"]["purple"]:
		purple_armor_unlock.queue_free()
	if stats["save_data"]["armors"]["brown"]:
		brown_armor_unlock.queue_free()
	if stats["save_data"]["armors"]["red"]:
		red_armor_unlock.queue_free()
	if stats["save_data"]["armors"]["yellow_2"]:
		yellow_armor_unlock.queue_free()
	if stats["save_data"]["armors"]["space"]:
		space_skin.queue_free()
	if stats["save_data"]["items"]["cape"]:
		flag.queue_free()
	if stats["save_data"]["items"]["belt"]:
		belt.queue_free()
	if stats["save_data"]["items"]["sombrero"]:
		sombrero.queue_free()

signal check_picnic
@warning_ignore("unused_parameter")
func _on_white_rose_body_entered(body):
	GlobalSteam.setAchievement("ACH_ROSE")
	stats["save_data"]["items"]["white_rose"] = true
	@warning_ignore("narrowing_conversion")
	sounds.play_sfx("pickup", randf_range(0.6,1.4), -10)
	white_rose.queue_free()
	SaveAndLoad.update_save_data()
	popup.emit("Found the White Rose")
	check_picnic.emit()

@warning_ignore("unused_parameter")
func _on_basket_body_entered(body):
	GlobalSteam.setAchievement("ACH_BASKET")
	stats["save_data"]["items"]["basket"] = true
	@warning_ignore("narrowing_conversion")
	sounds.play_sfx("pickup", randf_range(0.6,1.4), -10)
	basket.queue_free()
	SaveAndLoad.update_save_data()
	popup.emit("Found your Basket")
	check_picnic.emit()

@warning_ignore("unused_parameter")
func _on_towel_body_entered(body):
	GlobalSteam.setAchievement("ACH_TOWEL")
	stats["save_data"]["items"]["towel"] = true
	@warning_ignore("narrowing_conversion")
	sounds.play_sfx("pickup", randf_range(0.6,1.4), -10)
	towel.queue_free()
	SaveAndLoad.update_save_data()
	popup.emit("Found your Towel")
	check_picnic.emit()

@warning_ignore("unused_parameter")
func _on_wes_body_entered(body):
	stats["save_data"]["armors"]["wes"] = true
	@warning_ignore("narrowing_conversion")
	sounds.play_sfx("pickup", randf_range(0.6,1.4), -10)
	wes.queue_free()
	SaveAndLoad.update_save_data()
	popup.emit("You feel sus ultra...")

@warning_ignore("unused_parameter")
func _on_purple_armor_unlock_body_entered(body):
	stats["save_data"]["armors"]["purple"] = true
	@warning_ignore("narrowing_conversion")
	sounds.play_sfx("pickup", randf_range(0.6,1.4), -10)
	purple_armor_unlock.queue_free()
	SaveAndLoad.update_save_data()
	popup.emit("Mystic Armor Found!")

@warning_ignore("unused_parameter")
func _on_frog_body_entered(body):
	stats["save_data"]["armors"]["frog_real"] = true
	@warning_ignore("narrowing_conversion")
	sounds.play_sfx("pickup", randf_range(0.6,1.4), -10)
	frog.queue_free()
	SaveAndLoad.update_save_data()
	popup.emit("Frogorian Found!")

@warning_ignore("unused_parameter")
func _on_brown_armor_unlock_body_entered(body):
	stats["save_data"]["armors"]["brown"] = true
	@warning_ignore("narrowing_conversion")
	sounds.play_sfx("pickup", randf_range(0.6,1.4), -10)
	brown_armor_unlock.queue_free()
	SaveAndLoad.update_save_data()
	popup.emit("Armor was buried in the dirt!")

@warning_ignore("unused_parameter")
func _on_red_armor_unlock_body_entered(body):
	stats["save_data"]["armors"]["red"] = true
	@warning_ignore("narrowing_conversion")
	sounds.play_sfx("pickup", randf_range(0.6,1.4), -10)
	red_armor_unlock.queue_free()
	SaveAndLoad.update_save_data()
	popup.emit("Is this blood on the armor?!")

@warning_ignore("unused_parameter")
func _on_yellow_armor_unlock_body_entered(body):
	stats["save_data"]["armors"]["yellow_2"] = true
	@warning_ignore("narrowing_conversion")
	sounds.play_sfx("pickup", randf_range(0.6,1.4), -10)
	yellow_armor_unlock.queue_free()
	SaveAndLoad.update_save_data()
	popup.emit("That's no sunflower!")

@warning_ignore("unused_parameter")
func _on_space_skin_body_entered(body):
	stats["save_data"]["armors"]["space"] = true
	@warning_ignore("narrowing_conversion")
	sounds.play_sfx("pickup", randf_range(0.6,1.4), -10)
	space_skin.queue_free()
	SaveAndLoad.update_save_data()
	popup.emit("One giant leap for knightkind")

signal check_bart
@warning_ignore("unused_parameter")
func _on_flag_body_entered(body):
	stats["save_data"]["items"]["cape"] = true
	@warning_ignore("narrowing_conversion")
	sounds.play_sfx("pickup", randf_range(0.6,1.4), -10)
	flag.queue_free()
	SaveAndLoad.update_save_data()
	popup.emit("Cape of the Conqueror! You've donned the Mexican Flag Cape!")
	check_bart.emit()

@warning_ignore("unused_parameter")
func _on_belt_body_entered(body):
	stats["save_data"]["items"]["belt"] = true
	@warning_ignore("narrowing_conversion")
	sounds.play_sfx("pickup", randf_range(0.6,1.4), -10)
	belt.queue_free()
	SaveAndLoad.update_save_data()
	popup.emit("Feel the Rhythm of Victory! Champion Belt and Maracas acquired!")
	check_bart.emit()

@warning_ignore("unused_parameter")
func _on_sombrero_body_entered(body):
	stats["save_data"]["items"]["sombrero"] = true
	@warning_ignore("narrowing_conversion")
	sounds.play_sfx("pickup", randf_range(0.6,1.4), -10)
	sombrero.queue_free()
	SaveAndLoad.update_save_data()
	popup.emit("Mask of Legends: Become the hero of the ring!")
	check_bart.emit()
