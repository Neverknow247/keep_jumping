extends Area2D

var interactable = false
var interacting = false

@onready var chat_icon = $chat_icon

signal talk(_progression)
signal end_speech

var progression = 0

func _input(event):
	if (event.is_action_pressed("action") && interactable or event.is_action_pressed("controller_action")) && interactable:
		talk.emit(progression)


@warning_ignore("unused_parameter")
func _on_body_entered(body):
	interactable = true
	chat_icon.show()

@warning_ignore("unused_parameter")
func _on_body_exited(body):
	interactable = false
	chat_icon.hide()
	end_speech.emit()
