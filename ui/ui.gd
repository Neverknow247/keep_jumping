extends CanvasLayer

var stats = Stats

@onready var textbox = $textbox
@onready var rich_text_label = $textbox/RichTextLabel
@onready var character_art = $textbox/character_art
@onready var level_finish_menu = $level_finish_menu
@onready var pause_menu = $pause_menu
@onready var pop_up_label = $pop_up_label
@onready var transition = $transition
@onready var animation_player = $AnimationPlayer
@onready var crt_texture = $crt_texture

const characters = {
	"default":preload("res://assets/art/ui/character_headshots/default.png"),
	"mage_waving":preload("res://assets/art/ui/character_headshots/mage/wave.png"),
	"zombie_lost_eye":preload("res://assets/art/ui/character_headshots/zombie/lost_eye.png"),
	"zombie_found_eye":preload("res://assets/art/ui/character_headshots/zombie/found_eye.png"),
	"kid_zombie_with_eye":preload("res://assets/art/ui/character_headshots/child_zom/with_eye.png"),
	"kid_zombie_costume":preload("res://assets/art/ui/character_headshots/child_zom/kid_zombie_costume.png"),
	"granny_sitting":preload("res://assets/art/ui/character_headshots/granny_zom/sitting.png"),
	"girl_zombie_crying":preload("res://assets/art/ui/character_headshots/girl_zom/crying.png"),
	#"":preload(),
}

var next_level

signal start_level
signal un_pause

func enter_transition():
	animation_player.play("fade_in")

func exit_transition():
	animation_player.play("fade_out")

func emit_start_level():
	emit_signal("start_level")

func _ready():
	stats.pop_up.connect(pop_up)
	transition.visible = true
	pop_up_label.text = ""
	check_crt_filter()

func check_crt_filter():
	if stats["save_data"]["equiped_armor"] == "sir_knight":
		crt_texture.show()
	else:
		crt_texture.hide()

func _on_level_finish_menu_next_level():
	get_tree().change_scene_to_file(next_level)

func pop_up(text):
	pop_up_label.text = text
	await get_tree().create_timer(5).timeout
	pop_up_label.text = ""

func _on_pause_menu_fade_out():
	exit_transition()

func _on_level_finish_menu_fade_out():
	exit_transition()

func _on_pause_menu_un_pause():
	un_pause.emit()

func npc_speech(text,character="default"):
	character_art.texture = characters[character]
	rich_text_label.text = text
	textbox.show()

func end_speech():
	textbox.hide()
	rich_text_label.text = ""
