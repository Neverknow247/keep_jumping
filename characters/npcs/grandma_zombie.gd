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
		#state_progress()



#func state_progress():
	#match progression:
		#0:
			#if state == "sleep":
				#state = "wake_up"
				#wake_up()
				#sleep_zs.hide()
				#stats["save_data"]["mage_progression_next"] = 1
		#1:
			#if stats["save_data"]["mage_progression_next"] == 1:
				#stats["save_data"]["mage_progression_next"] = 2

@warning_ignore("unused_parameter")
func _on_body_entered(body):
	interactable = true
	chat_icon.show()

@warning_ignore("unused_parameter")
func _on_body_exited(body):
	interactable = false
	chat_icon.hide()
	end_speech.emit()
