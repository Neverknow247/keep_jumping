extends TextureRect

var stats = Stats
var sounds = Sounds
var utils = Utils

@onready var transition = $transition
@onready var easter_egg_button = $easter_egg_button

var easter_egg_audio = "angel_1_1"
var game_board = "res://levels/level_1.tscn"
var opening_board = "res://levels/opening_scene.tscn"


func _ready():
	RenderingServer.set_default_clear_color(Color.BLACK)
	sounds.play_sfx("smell_this_bread",1,-15)
	await get_tree().create_timer(1.2).timeout
	easter_egg_button.disabled = false
	await get_tree().create_timer(1).timeout
	easter_egg_button.disabled = true
	await get_tree().create_timer(.3).timeout
	start()

func check_achievements():
	await check_demo()
	return true

func check_dlc():
	var checked_supporter_dlc = GlobalSteam.check_supporter_dlc_install()
	var checked_phoenix_dlc = GlobalSteam.check_phoenix_dlc_install()
	stats["save_data"]["armors"]["gold"] = false
	stats["save_data"]["phoenix_dlc"] = false
	if checked_supporter_dlc==true:
		stats["save_data"]["armors"]["gold"] = true
	if checked_phoenix_dlc == true:
		stats["save_data"]["phoenix_dlc"] = true
	finish()

func check_demo():
	if !stats["save_data"]["demo_complete"]:
		var demo_data = await load_data_from_file()
		if !demo_data:
			return true
		else:
			if demo_data["level_data"]["level_1_demo"]["_normal_reunions"] > 0:
				stats["save_data"]["demo_complete"] = true
				GlobalSteam.setAchievement("ACH_DEMO")
			return true
	else:
		return true

func load_data_from_file():
	var dir = DirAccess.open("user://")
	var demo_save_path = "user://%s/save_data.dat"%[str(GlobalSteam.logged_in_id)]
	if !dir.dir_exists("%s"%[str(GlobalSteam.logged_in_id)]):
		return false
	else:
		if not FileAccess.file_exists(demo_save_path):
			return false
	var file = FileAccess.open(demo_save_path, FileAccess.READ)
	var demo_data = file.get_var()
	if !demo_data:
		return false
	else:
		return demo_data

func start():
	await SaveAndLoad.load_settings()
	utils.set_volume()
	if await SaveAndLoad.load_data():
		utils.set_keybindings()
		stats["save_data"]["stats"]["Power On Count"] += 1
		await SaveAndLoad.save_all()
		await check_achievements()
		check_dlc()

func finish():
	transition.fade_out()
	await get_tree().create_timer(stats.transition_time).timeout
	#get_tree().change_scene_to_file(game_board)
	get_tree().change_scene_to_file(opening_board)

func _on_easter_egg_button_pressed():
	easter_egg_button.disabled = true
	sounds.play_voice(easter_egg_audio,1,-10)
