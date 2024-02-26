extends AnimatedSprite2D

var stats = Stats
var utils = Utils

@export var top_fade = true
@export var bottom_fade = true

@onready var fade = $fade
@onready var fade_top = $fade_top
@onready var fade_bottom = $fade_bottom
@onready var label = $Label

@onready var key_data = [
	{
		"name":"jump",
		"label":""
	},
	{
		"name":"down",
		"label":""
	},
	{
		"name":"left",
		"label":""
	},
	{
		"name":"right",
		"label":""
	},
	{
		"name":"bury",
		"label":""
	},
	{
		"name":"controller_jump",
		"label":""
	},
	{
		"name":"controller_down",
		"label":""
	},
	{
		"name":"controller_left",
		"label":""
	},
	{
		"name":"controller_right",
		"label":""
	},
	{
		"name":"controller_bury",
		"label":""
	},
]

@onready var tutorial_text = {
	"keyboard":{
		"default":"",
		"jump":"",
		"high_jump":"",
		"double_jump":"",
		"wall_jump":"",
		"wall_slide":"",
		"fast_wall_jump":"",
		"turn_jump":"",
		"coyote":"",
		"bone":"",
		"finish":"",
	},
	"controller":{
		"default":"",
		"jump":"",
		"high_jump":"",
		"double_jump":"",
		"wall_jump":"",
		"wall_slide":"",
		"fast_wall_jump":"",
		"turn_jump":"",
		"coyote":"",
		"bone":"",
		"finish":"",
	}
}
var controls = "keyboard"

func _ready():
	fade_top.visible = top_fade
	fade_bottom.visible = bottom_fade
	_update_labels()
	set_text()

func _input(event):
	if event is InputEventJoypadButton || event is InputEventJoypadMotion:
		controls = "controller"
		set_text()
	elif event is InputEventKey || event is InputEventMouseButton:
		controls = "keyboard"
		set_text()

func set_text():
	label.text = tutorial_text[controls][animation]

func _update_labels():
	for data in key_data:
		var button : Array[InputEvent] = InputMap.action_get_events(data["name"])
		if !button.is_empty():
			var new_text = button[0].as_text()
			new_text = clean_text(new_text)
			data["label"] = new_text
		else:
			data["label"] = ""
	tutorial_text = {
		"keyboard":{
			"default":"\n\n\n\n\nMove with: %s and %s"%[key_data[2]["label"],key_data[3]["label"]],
			"jump":"\n\n\n\n\nJump by pressing: %s"%[key_data[0]["label"]],
			"high_jump":"\n\n\n\n\nHold %s to jump higher!"%[key_data[0]["label"]],
			"double_jump":"\n\n\n\n\nJump again while in the Air!",
			"wall_jump":"\n\n\n\n\nJump while on a Wall to climb.",
			"wall_slide":"Slide Faster while holding: %s\n\n\n\nThis will also make you fall faster in air."%[key_data[1]["label"]],
			"fast_wall_jump":"",
			"turn_jump":"",
			"coyote":"Jump right after you leave a ledge.\n\n\n\nThis will give you a small speed boost.",
			"bone":"Find the hidden bone in every level.\n\n\n\nBury the bone to create a heal place: %s"%[key_data[4]["label"]],
			"finish":"\n\n\n\n\nEnter the Dog House to finish the level!",
		},
		"controller":{
			"default":"\n\n\n\n\nMove with: %s and %s"%[key_data[7]["label"],key_data[8]["label"]],
			"jump":"\n\n\n\n\nJump by pressing: %s"%[key_data[5]["label"]],
			"high_jump":"\n\n\n\n\nHold %s to jump higher!"%[key_data[5]["label"]],
			"double_jump":"\n\n\n\n\nJump again while in the Air!",
			"wall_jump":"\n\n\n\n\nJump while on a Wall to climb.",
			"wall_slide":"Slide Faster while holding: %s\n\n\n\nThis will also make you fall faster in air."%[key_data[6]["label"]],
			"fast_wall_jump":"",
			"turn_jump":"",
			"coyote":"Jump right after you leave a ledge.\n\n\n\nThis will give you a small speed boost.",
			"bone":"Find the hidden bone in every level.\n\n\n\nBury the bone to create a heal place: %s"%[key_data[9]["label"]],
			"finish":"\n\n\n\n\nEnter the Dog House to finish the level!",
		}
	}

func clean_text(new_text):
	var check_1
	var check_2
	if new_text.find("Xbox") != -1:
		check_1 = new_text.find("Xbox")
		check_1+=5
		check_2 = new_text.find(",",check_1)
		if check_2 == -1:
			check_2 = new_text.find(")",check_1)
		if check_1 != -1 and check_2 != -1:
			new_text = new_text.substr(check_1,check_2-check_1)
			return new_text
	elif new_text.find("D-pad") != -1:
		check_1 = new_text.find("D-pad")
		check_2 = new_text.find(")",check_1)
		if check_1 != -1 and check_2 != -1:
			new_text = new_text.substr(check_1,check_2-check_1)
			return new_text
	elif new_text.find("Left Stick") != -1:
		new_text = "Left Stick"
		return new_text
	elif new_text.find("Right Stick") != -1:
		new_text = "Right Stick"
		return new_text
	return new_text

func _on_area_2d_body_entered(body):
	play(animation)
	label.show()
	fade.hide()

func _on_area_2d_body_exited(body):
	pause()
	label.hide()
	fade.show()
