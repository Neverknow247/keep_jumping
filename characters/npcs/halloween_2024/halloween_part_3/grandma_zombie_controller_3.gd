extends Npc_Controller

signal legs_eaten

func _on_talk(_progression):
	super(_progression)
	if progression > dialogue_script["dialogue"][_progression].size()-1 and $grandma_zombie.progression == 0:
		$grandma_zombie.progression = 1
	elif progression > dialogue_script["dialogue"][_progression].size()-1 and $grandma_zombie.progression == 1:
		$grandma_zombie.progression = 2
		legs_eaten.emit()
