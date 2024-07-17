extends Node2D
class_name Npc_Controller

var stats = Stats

var progression = 0
@export var states_num : Array[Array]

signal talk(text)

func _ready():
	pass

func _on_talk(_progression):
	if progression > states_num[_progression].size()-1:
		progression = max(progression-2,0)
	talk.emit(states_num[_progression][progression])
	progression += 1
