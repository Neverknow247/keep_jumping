extends Area2D

@onready var chat_icon = $chat_icon

var interactable = true
var interacting = false
var state = "sleep"
var state_stage = 0

@warning_ignore("unused_parameter")
func _on_body_entered(body):
	interactable = true
	#chat_icon.show()

@warning_ignore("unused_parameter")
func _on_body_exited(body):
	interactable = false
	#chat_icon.hide()

func _input(event):
	if (event.is_action_pressed("action") or event.is_action_pressed("controller_action")) && interactable:
		print("hello")
