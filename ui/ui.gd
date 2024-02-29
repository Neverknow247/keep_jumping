extends CanvasLayer

var stats = Stats

@onready var level_finish_menu = $level_finish_menu
@onready var pause_menu = $pause_menu
@onready var pop_up_label = $pop_up_label
@onready var transition = $transition
@onready var animation_player = $AnimationPlayer

var next_level

signal start_level

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


func _on_level_finish_menu_next_level():
	get_tree().change_scene_to_file(next_level)

func pop_up(type,text):
	if type == "egg":
		pop_up_label.text = "* New %s Unlocked *" %[text]
	elif type == "bone":
		pop_up_label.text = "* %s Discovered *" %[text]
	elif type == "message":
		pop_up_label.text = "! %s !" %[text]
	await get_tree().create_timer(2).timeout
	pop_up_label.text = ""

func _on_pause_menu_fade_out():
	exit_transition()

func _on_level_finish_menu_fade_out():
	exit_transition()
