extends Npc_Controller

signal happy_halloween(character)

func _on_talk(_progression):
	super(_progression)
	if progression > dialogue_script["dialogue"][_progression].size()-1 and $kid_zombie.progression == 0:
		$kid_zombie.progression = 1
	elif progression > dialogue_script["dialogue"][_progression].size()-1 and $kid_zombie.progression == 1:
		happy_halloween.emit("kid")
