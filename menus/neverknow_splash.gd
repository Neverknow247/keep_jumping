extends TextureRect

var stats = Stats
var sounds = Sounds
var utils = Utils

@onready var transition = $transition
@onready var easter_egg_button = $easter_egg_button

var easter_egg_audio = "angel_1_1"
var menu_board = "res://levels/level_1.tscn"
#var menu_board = "res://menus/main_menu.tscn"


func _ready():
	RenderingServer.set_default_clear_color(Color.BLACK)
	sounds.play_sfx("smell_this_bread",1,-10)
	await get_tree().create_timer(3).timeout
	start()

func start():
	await SaveAndLoad.load_settings()
	if await SaveAndLoad.load_data():
		utils.set_volume()
		utils.set_keybindings()
		stats["save_data"]["stats"]["Power On Count"] += 1
		await SaveAndLoad.save_all()
		transition.fade_out()
		await get_tree().create_timer(stats.transition_time).timeout
		get_tree().change_scene_to_file(menu_board)

func _on_easter_egg_button_pressed():
	easter_egg_button.disabled = true
	sounds.play_voice(easter_egg_audio,1,-5)
