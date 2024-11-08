extends Npc_Controller

var sounds = Sounds

signal finished_talking_to_mage
signal popup(text)

func _on_talk(_progression):
	super(_progression)
	if progression > dialogue_script["dialogue"][_progression].size()-1 and $mage.progression == 1:
		$mage.progression = 2
		@warning_ignore("narrowing_conversion")
		sounds.play_sfx("pickup", randf_range(0.6,1.4), -10)
		popup.emit("Gain ability to speak while in ghost form!")
		#$kid_zombie/AnimatedSprite2D.animation = "new_idle"
		finished_talking_to_mage.emit()
