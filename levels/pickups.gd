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
@onready var sand_armor = $sand_armor
@onready var upper_armor = $upper_armor
@onready var lava_armor = $lava_armor
@onready var lava_armor_2 = $lava_armor_2
@onready var lava_armor_3 = $lava_armor_3
@onready var lower_armor = $lower_armor
@onready var hidden_armor = $hidden_armor
@onready var inverted_armor = $inverted_armor
@onready var arcade_unlock_1 = $arcade_unlock_1
@onready var arcade_unlock_2 = $arcade_unlock_2
@onready var arcade_unlock_3 = $arcade_unlock_3
@onready var arcade_unlock_4 = $arcade_unlock_4
@onready var arcade_unlock_5 = $arcade_unlock_5
@onready var toilet_2_unlock = $toilet_2_unlock
@onready var bish_armor = $bish_armor
@onready var santa_1_armor = $santa_1_armor

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
	if stats["save_data"]["armors"]["sand"]:
		sand_armor.queue_free()
	if stats["save_data"]["armors"]["upper"]:
		upper_armor.queue_free()
	if stats["save_data"]["armors"]["lava"]:
		lava_armor.queue_free()
	if stats["save_data"]["armors"]["lava_2"]:
		lava_armor_2.queue_free()
	if stats["save_data"]["armors"]["lava_3"]:
		lava_armor_3.queue_free()
	if stats["save_data"]["armors"]["lower"]:
		lower_armor.queue_free()
	if stats["save_data"]["armors"]["hidden"]:
		hidden_armor.queue_free()
	if stats["save_data"]["armors"]["inverted"]:
		inverted_armor.queue_free()
	if stats["save_data"]["items"]["arcade_1"]:
		arcade_unlock_1.queue_free()
	if stats["save_data"]["items"]["arcade_2"]:
		arcade_unlock_2.queue_free()
	if stats["save_data"]["items"]["arcade_3"]:
		arcade_unlock_3.queue_free()
	if stats["save_data"]["items"]["arcade_4"]:
		arcade_unlock_4.queue_free()
	if stats["save_data"]["items"]["arcade_5"]:
		arcade_unlock_5.queue_free()
	if stats["save_data"]["items"]["toilet_2"]:
		toilet_2_unlock.queue_free()
	if stats["save_data"]["armors"]["bish"]:
		bish_armor.queue_free()
	if stats["save_data"]["armors"]["santa_1"]:
		santa_1_armor.queue_free()

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

@warning_ignore("unused_parameter")
func _on_sand_armor_body_entered(body):
	stats["save_data"]["armors"]["sand"] = true
	@warning_ignore("narrowing_conversion")
	sounds.play_sfx("pickup", randf_range(0.6,1.4), -10)
	sand_armor.queue_free()
	SaveAndLoad.update_save_data()
	popup.emit("Desert Power!")

@warning_ignore("unused_parameter")
func _on_upper_armor_body_entered(body):
	stats["save_data"]["armors"]["upper"] = true
	@warning_ignore("narrowing_conversion")
	sounds.play_sfx("pickup", randf_range(0.6,1.4), -10)
	upper_armor.queue_free()
	SaveAndLoad.update_save_data()
	popup.emit("The gold standard!")

@warning_ignore("unused_parameter")
func _on_lava_armor_body_entered(body):
	stats["save_data"]["armors"]["lava"] = true
	@warning_ignore("narrowing_conversion")
	sounds.play_sfx("pickup", randf_range(0.6,1.4), -10)
	lava_armor.queue_free()
	SaveAndLoad.update_save_data()
	popup.emit("Burn level: Expert")

@warning_ignore("unused_parameter")
func _on_lava_armor_2_body_entered(body):
	stats["save_data"]["armors"]["lava_2"] = true
	@warning_ignore("narrowing_conversion")
	sounds.play_sfx("pickup", randf_range(0.6,1.4), -10)
	lava_armor_2.queue_free()
	SaveAndLoad.update_save_data()
	popup.emit("Hot stuff incoming!")

@warning_ignore("unused_parameter")
func _on_lava_armor_3_body_entered(body):
	stats["save_data"]["armors"]["lava_3"] = true
	@warning_ignore("narrowing_conversion")
	sounds.play_sfx("pickup", randf_range(0.6,1.4), -10)
	lava_armor_3.queue_free()
	SaveAndLoad.update_save_data()
	popup.emit("Lava you long time!")

@warning_ignore("unused_parameter")
func _on_lower_armor_body_entered(body):
	stats["save_data"]["armors"]["lower"] = true
	@warning_ignore("narrowing_conversion")
	sounds.play_sfx("pickup", randf_range(0.6,1.4), -10)
	lower_armor.queue_free()
	SaveAndLoad.update_save_data()
	popup.emit("The silver lining")

@warning_ignore("unused_parameter")
func _on_hidden_armor_body_entered(body):
	stats["save_data"]["armors"]["hidden"] = true
	@warning_ignore("narrowing_conversion")
	sounds.play_sfx("pickup", randf_range(0.6,1.4), -10)
	hidden_armor.queue_free()
	SaveAndLoad.update_save_data()
	popup.emit("Bronze is the new black.")

@warning_ignore("unused_parameter")
func _on_inverted_armor_body_entered(body):
	stats["save_data"]["armors"]["inverted"] = true
	@warning_ignore("narrowing_conversion")
	sounds.play_sfx("pickup", randf_range(0.6,1.4), -10)
	inverted_armor.queue_free()
	SaveAndLoad.update_save_data()
	popup.emit("Not your average knight!")

@warning_ignore("unused_parameter")
func _on_arcade_unlock_1_body_entered(body):
	GlobalSteam.setAchievement("ACH_ARCADE_1")
	stats["save_data"]["items"]["arcade_1"] = true
	@warning_ignore("narrowing_conversion")
	sounds.play_sfx("pickup", randf_range(0.6,1.4), -10)
	arcade_unlock_1.queue_free()
	SaveAndLoad.update_save_data()
	popup.emit("Level 1/5: First quest unlocked!")

@warning_ignore("unused_parameter")
func _on_arcade_unlock_2_body_entered(body):
	GlobalSteam.setAchievement("ACH_ARCADE_2")
	stats["save_data"]["items"]["arcade_2"] = true
	@warning_ignore("narrowing_conversion")
	sounds.play_sfx("pickup", randf_range(0.6,1.4), -10)
	arcade_unlock_2.queue_free()
	SaveAndLoad.update_save_data()
	popup.emit("Level 2/5: Power up, hero!")

@warning_ignore("unused_parameter")
func _on_arcade_unlock_3_body_entered(body):
	GlobalSteam.setAchievement("ACH_ARCADE_3")
	stats["save_data"]["items"]["arcade_3"] = true
	@warning_ignore("narrowing_conversion")
	sounds.play_sfx("pickup", randf_range(0.6,1.4), -10)
	arcade_unlock_3.queue_free()
	SaveAndLoad.update_save_data()
	popup.emit("Level 3/5: The plot thickens!")

@warning_ignore("unused_parameter")
func _on_arcade_unlock_4_body_entered(body):
	GlobalSteam.setAchievement("ACH_ARCADE_4")
	stats["save_data"]["items"]["arcade_4"] = true
	@warning_ignore("narrowing_conversion")
	sounds.play_sfx("pickup", randf_range(0.6,1.4), -10)
	arcade_unlock_4.queue_free()
	SaveAndLoad.update_save_data()
	popup.emit("Level 4/5: Show your mettle!")

@warning_ignore("unused_parameter")
func _on_arcade_unlock_5_body_entered(body):
	GlobalSteam.setAchievement("ACH_ARCADE_5")
	stats["save_data"]["items"]["arcade_5"] = true
	@warning_ignore("narrowing_conversion")
	sounds.play_sfx("pickup", randf_range(0.6,1.4), -10)
	arcade_unlock_5.queue_free()
	SaveAndLoad.update_save_data()
	popup.emit("Level 5/5: Sir Knight's last stand!")

@warning_ignore("unused_parameter")
func _on_toilet_2_unlock_body_entered(body):
	stats["save_data"]["items"]["toilet_2"] = true
	@warning_ignore("narrowing_conversion")
	sounds.play_sfx("pickup", randf_range(0.6,1.4), -10)
	toilet_2_unlock.queue_free()
	SaveAndLoad.update_save_data()
	popup.emit("Toilet 2 Unlocked!")

@warning_ignore("unused_parameter")
func _on_bish_armor_body_entered(body):
	stats["save_data"]["armors"]["bish"] = true
	@warning_ignore("narrowing_conversion")
	sounds.play_sfx("pickup", randf_range(0.6,1.4), -10)
	bish_armor.queue_free()
	SaveAndLoad.update_save_data()
	popup.emit("It's Slime to fall!")

@warning_ignore("unused_parameter")
func _on_santa_1_armor_body_entered(body):
	stats["save_data"]["armors"]["santa_1"] = true
	@warning_ignore("narrowing_conversion")
	sounds.play_sfx("pickup", randf_range(0.6,1.4), -10)
	santa_1_armor.queue_free()
	SaveAndLoad.update_save_data()
	popup.emit("In putting on this hat, the wearer enters into the Claus...")
