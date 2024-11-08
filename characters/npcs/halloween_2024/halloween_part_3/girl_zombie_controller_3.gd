extends Npc_Controller

var sounds = Sounds

signal popup(text)

func _on_talk(_progression):
	super(_progression)
	if progression > dialogue_script["dialogue"][_progression].size()-1 and $girl_zombie.progression == 2:
		$girl_zombie.progression = 3
		if !stats["save_data"]["akamaru_skins"]["glasses"]:
			stats["save_data"]["akamaru_skins"]["glasses"] = true
			@warning_ignore("narrowing_conversion")
			sounds.play_sfx("pickup", randf_range(0.6,1.4), -10)
			popup.emit("Unlocked Glasses Akamaru. Available for customization soon.")
			SaveAndLoad.update_save_data()

	#if progression > dialogue_script["dialogue"][_progression].size()-1 and $girl_zombie.progression == 2:
		#$girl_zombie.progression = 3
		#@warning_ignore("narrowing_conversion")
		#sounds.play_sfx("pickup", randf_range(0.6,1.4), -10)
		#popup.emit("One step in the grave. Unlocked Ghost Armor")
