extends Npc_Controller

var sounds = Sounds

signal open_exit_door
signal popup(text)

func _on_talk(_progression):
	super(_progression)
	if progression > dialogue_script["dialogue"][_progression].size()-1 and $girl_zombie.progression == 2:
		$girl_zombie.progression = 3
		#$kid_zombie/AnimatedSprite2D.animation = "new_idle"
		open_exit_door.emit()
		@warning_ignore("narrowing_conversion")
		sounds.play_sfx("pickup", randf_range(0.6,1.4), -10)
		popup.emit("One step in the grave. Unlocked Ghost Armor")
