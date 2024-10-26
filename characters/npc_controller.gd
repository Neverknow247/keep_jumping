extends Node2D
class_name Npc_Controller

var stats = Stats

var progression = 0
@export var dialogue_script : Resource

signal talk(text)
signal end_speech

func _ready():
	pass

func _on_talk(_progression):
	if progression > dialogue_script["dialogue"][_progression].size()-1:
		#progression = max(progression-2,0)
		progression = 0
		end_speech.emit()
		return
	talk.emit(dialogue_script["dialogue"][_progression][progression][0],dialogue_script["dialogue"][_progression][progression][1])
	progression += 1
