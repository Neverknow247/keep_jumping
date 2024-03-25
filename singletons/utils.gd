extends Node

var stats = Stats

var volume_settings = {
	"master_volume" = .5,
	"music_volume" = 1,
	"sfx_volume" = 1,
	"voice_volume" = 1
}

const master_bus_name = "Master"
const music_bus_name = "Music"
const sfx_bus_name = "SFX"
const voice_bus_name = "Voice"

@onready var master_bus = AudioServer.get_bus_index(master_bus_name)
@onready var music_bus = AudioServer.get_bus_index(music_bus_name)
@onready var sfx_bus = AudioServer.get_bus_index(sfx_bus_name)
@onready var voice_bus = AudioServer.get_bus_index(voice_bus_name)

func set_volume():
	AudioServer.set_bus_volume_db(master_bus, linear_to_db(volume_settings["master_volume"]))
	AudioServer.set_bus_volume_db(music_bus, linear_to_db(volume_settings["music_volume"]))
	AudioServer.set_bus_volume_db(sfx_bus, linear_to_db(volume_settings["sfx_volume"]))
	AudioServer.set_bus_volume_db(voice_bus, linear_to_db(volume_settings["voice_volume"]))

signal change_color_blind_textures
var color_blind_mode = false:
	get:
		return color_blind_mode
	set(value):
		color_blind_mode = value
		change_color_blind_textures.emit()

var input_types = {
	"key":InputEventKey,
	"mouse":InputEventMouseButton,
	"button":InputEventJoypadButton,
	"motion":InputEventJoypadMotion
}

var keybindings = {
	"left":InputEventKey.new(),
	"right":InputEventKey.new(),
	"down":InputEventKey.new(),
	"jump":InputEventKey.new(),
	"action":InputEventKey.new(),
	"controller_left":InputEventJoypadButton.new(),
	"controller_right":InputEventJoypadButton.new(),
	"controller_down":InputEventJoypadButton.new(),
	"controller_jump":InputEventJoypadButton.new(),
	"controller_action":InputEventJoypadButton.new(),
}

var bindings = {
	"left":{
		"type":"key",
		"keycode":65,
		"button_index":1
	},
	"right":{
		"type":"key",
		"keycode":68,
		"button_index":1
	},
	"down":{
		"type":"key",
		"keycode":83,
		"button_index":1
	},
	"jump":{
		"type":"key",
		"keycode":32,
		"button_index":1
	},
	"action":{
		"type":"key",
		"keycode":69,
		"button_index":1
	},
	"controller_left":{
		"type":"button",
		"button_index":13,
		"axis":0,
		"axis_value":0.0
	},
	"controller_right":{
		"type":"button",
		"button_index":14,
		"axis":0,
		"axis_value":0.0
	},
	"controller_down":{
		"type":"button",
		"button_index":12,
		"axis":0,
		"axis_value":0.0
	},
	"controller_jump":{
		"type":"button",
		"button_index":0,
		"axis":0,
		"axis_value":0.0
	},
	"controller_action":{
		"type":"button",
		"button_index":1,
		"axis":0,
		"axis_value":0.0
	},
}

func set_keybindings():
	for key in keybindings:
		keybindings[key] = input_types[bindings[key]["type"]].new()
		if bindings[key]["type"] == "key":
			keybindings[key].keycode = bindings[key]["keycode"]
		elif bindings[key]["type"] == "motion":
			keybindings[key].axis = bindings[key]["axis"]
			keybindings[key].axis_value = bindings[key]["axis_value"]
		elif bindings[key]["type"] == "mouse" || bindings[key]["type"] == "button":
			keybindings[key].button_index = bindings[key]["button_index"]
	for key in keybindings:
		var all_ies : Dictionary = {}
		for ia in InputMap.get_actions():
			for iae in InputMap.action_get_events(ia):
				all_ies[iae.as_text()] = ia
		if all_ies.keys().has(keybindings[key].as_text()):
			InputMap.action_erase_events(all_ies[keybindings[key].as_text()])
		InputMap.action_erase_events(key)
		InputMap.action_add_event(key,keybindings[key])

