extends TextureRect

var stats = Stats
var sounds = Sounds
var utils = Utils

@onready var transition = $transition
@onready var easter_egg_button = $easter_egg_button

var easter_egg_audio = "angel_1_1"
var game_board = "res://levels/level_1.tscn"


func _ready():
	RenderingServer.set_default_clear_color(Color.BLACK)
	sounds.play_sfx("smell_this_bread",1,-15)
	check_achievements()
	await get_tree().create_timer(1.2).timeout
	easter_egg_button.disabled = false
	await get_tree().create_timer(1).timeout
	easter_egg_button.disabled = true
	await get_tree().create_timer(.3).timeout
	start()

func check_achievements():
	if stats["save_data"]["stats"]["Total Reunions"]:
		GlobalSteam.setAchievement("ACH_FINISH")
	if stats["demo"]:
		if stats["save_data"]["level_data"]["level_1_demo"]["_normal_time"] <= 1800.0000:
			GlobalSteam.setAchievement("ACH_30_MIN")
		if stats["save_data"]["level_data"]["level_1_demo"]["_normal_time"] <= 69.0000:
			GlobalSteam.setAchievement("ACH_69")

func start():
	await SaveAndLoad.load_settings()
	utils.set_volume()
	if await SaveAndLoad.load_data():
		utils.set_keybindings()
		stats["save_data"]["stats"]["Power On Count"] += 1
		await SaveAndLoad.save_all()
		transition.fade_out()
		await get_tree().create_timer(stats.transition_time).timeout
		get_tree().change_scene_to_file(game_board)

func _on_easter_egg_button_pressed():
	easter_egg_button.disabled = true
	sounds.play_voice(easter_egg_audio,1,-10)
