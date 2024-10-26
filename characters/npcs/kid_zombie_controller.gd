extends Npc_Controller

signal finished_kid_zombie_quest

func _on_talk(_progression):
	super(_progression)
	if progression > dialogue_script["dialogue"][_progression].size()-1 and $kid_zombie.progression == 1:
		$kid_zombie.progression = 2
		#$kid_zombie/AnimatedSprite2D.animation = "new_idle"
		finished_kid_zombie_quest.emit()
