extends Control

signal hide_menu(scene)

var current_button : Button

@onready var jump = $CenterContainer/HBoxContainer/VBoxContainer/HBoxContainer2/jump
@onready var jump_label = $CenterContainer/HBoxContainer/VBoxContainer/HBoxContainer2/jump_label
@onready var down = $CenterContainer/HBoxContainer/VBoxContainer/HBoxContainer/down
@onready var down_label = $CenterContainer/HBoxContainer/VBoxContainer/HBoxContainer/down_label
@onready var left = $CenterContainer/HBoxContainer/VBoxContainer/HBoxContainer3/left
@onready var left_label = $CenterContainer/HBoxContainer/VBoxContainer/HBoxContainer3/left_label
@onready var right = $CenterContainer/HBoxContainer/VBoxContainer/HBoxContainer4/right
@onready var right_label = $CenterContainer/HBoxContainer/VBoxContainer/HBoxContainer4/right_label
@onready var action = $CenterContainer/HBoxContainer/VBoxContainer/HBoxContainer5/action
@onready var action_label = $CenterContainer/HBoxContainer/VBoxContainer/HBoxContainer5/action_label

@onready var controller_left = $CenterContainer/HBoxContainer/VBoxContainer2/HBoxContainer3/controller_left
@onready var controller_left_label = $CenterContainer/HBoxContainer/VBoxContainer2/HBoxContainer3/left_label
@onready var controller_right = $CenterContainer/HBoxContainer/VBoxContainer2/HBoxContainer4/controller_right
@onready var controller_right_label = $CenterContainer/HBoxContainer/VBoxContainer2/HBoxContainer4/right_label
@onready var controller_jump = $CenterContainer/HBoxContainer/VBoxContainer2/HBoxContainer2/controller_jump
@onready var controller_jump_label = $CenterContainer/HBoxContainer/VBoxContainer2/HBoxContainer2/jump_label
@onready var controller_down = $CenterContainer/HBoxContainer/VBoxContainer2/HBoxContainer/controller_down
@onready var controller_down_label = $CenterContainer/HBoxContainer/VBoxContainer2/HBoxContainer/down_label
@onready var controller_action = $CenterContainer/HBoxContainer/VBoxContainer2/HBoxContainer5/controller_action
@onready var controller_action_label = $CenterContainer/HBoxContainer/VBoxContainer2/HBoxContainer5/action_label


@onready var all_buttons = [
	jump,down,left,right,action,
	controller_jump,controller_down,controller_left,controller_right,controller_action
]

@onready var panel_container = $PanelContainer
@onready var label = $PanelContainer/Label

var active = false

func _ready():
	_update_labels()
	jump.pressed.connect(_on_button_pressed.bind(jump))
	down.pressed.connect(_on_button_pressed.bind(down))
	left.pressed.connect(_on_button_pressed.bind(left))
	right.pressed.connect(_on_button_pressed.bind(right))
	action.pressed.connect(_on_button_pressed.bind(action))
	controller_jump.pressed.connect(_on_button_pressed.bind(controller_jump))
	controller_down.pressed.connect(_on_button_pressed.bind(controller_down))
	controller_left.pressed.connect(_on_button_pressed.bind(controller_left))
	controller_right.pressed.connect(_on_button_pressed.bind(controller_right))
	controller_action.pressed.connect(_on_button_pressed.bind(controller_action))

func _on_button_pressed(button:Button):
	@warning_ignore("narrowing_conversion")
	Sounds.play_sfx("click",randf_range(.8,1.2),-10)
	disable_buttons(true)
	current_button = button
	panel_container.show()

func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel") and active:
		_on_back_button_pressed()

func _input(event):
	if !current_button:
		return
	if current_button.is_in_group("keyboard"):
		if event is InputEventKey || event is InputEventMouseButton:
			var all_ies : Dictionary = {}
			for ia in InputMap.get_actions():
				for iae in InputMap.action_get_events(ia):
					all_ies[iae.as_text()] = ia
			if all_ies.keys().has(event.as_text()):
				InputMap.action_erase_events(all_ies[event.as_text()])
			InputMap.action_erase_events(current_button.name)
			InputMap.action_add_event(current_button.name,event)
			if event is InputEventKey:
				Utils.bindings[current_button.name]["type"] = "key" 
				Utils.bindings[current_button.name]["keycode"] = event.keycode
			else:
				Utils.bindings[current_button.name]["type"] = "mouse" 
				Utils.bindings[current_button.name]["button_index"] = event.button_index
			current_button = null
			panel_container.hide()
			_update_labels()
			await get_tree().create_timer(.5).timeout
			disable_buttons(false)
	elif current_button.is_in_group("controller"):
		if event is InputEventJoypadButton || event is InputEventJoypadMotion:
			var all_ies : Dictionary = {}
			for ia in InputMap.get_actions():
				for iae in InputMap.action_get_events(ia):
					all_ies[iae.as_text()] = ia
			if all_ies.keys().has(event.as_text()):
				InputMap.action_erase_events(all_ies[event.as_text()])
			InputMap.action_erase_events(current_button.name)
			InputMap.action_add_event(current_button.name,event)
			if event is InputEventJoypadButton:
				Utils.bindings[current_button.name]["type"] = "button" 
				Utils.bindings[current_button.name]["button_index"] = event.button_index
			else:
				Utils.bindings[current_button.name]["type"] = "motion" 
				Utils.bindings[current_button.name]["axis"] = event.axis
				Utils.bindings[current_button.name]["axis_value"] = event.axis_value
			current_button = null
			panel_container.hide()
			_update_labels()
			await get_tree().create_timer(.5).timeout
			disable_buttons(false)

@onready var key_data = [
	{
		"name":"jump",
		"label":jump_label
	},
	{
		"name":"down",
		"label":down_label
	},
	{
		"name":"left",
		"label":left_label
	},
	{
		"name":"right",
		"label":right_label
	},
	{
		"name":"action",
		"label":action_label
	},
	{
		"name":"controller_jump",
		"label":controller_jump_label
	},
	{
		"name":"controller_down",
		"label":controller_down_label
	},
	{
		"name":"controller_left",
		"label":controller_left_label
	},
	{
		"name":"controller_right",
		"label":controller_right_label
	},
	{
		"name":"controller_action",
		"label":controller_action_label
	},
]

func _update_labels():
	for data in key_data:
		var button : Array[InputEvent] = InputMap.action_get_events(data["name"])
		if !button.is_empty():
			data["label"].text = button[0].as_text()
		else:
			data["label"].text = ""

func _on_back_button_pressed():
	@warning_ignore("narrowing_conversion")
	Sounds.play_sfx("click",randf_range(.8,1.2),-10)
	SaveAndLoad.update_settings()
	active = false
	hide_menu.emit(self)

func disable_buttons(disable):
	for button in all_buttons:
		button.disabled = disable
