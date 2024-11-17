extends Npc_Controller

var sounds = Sounds

signal popup(text)

signal happy_halloween(character)

func _on_talk(_progression):
	super(_progression)
	if progression > dialogue_script["dialogue"][_progression].size()-1 and $girl_zombie.progression == 0:
		if stats["save_data"]["akamaru_skins"]["glasses"]:
			$girl_zombie.progression = 2
		else:
			$girl_zombie.progression = 1
	elif progression > dialogue_script["dialogue"][_progression].size()-1 and $girl_zombie.progression == 1:
		$girl_zombie.progression = 2
	elif progression > dialogue_script["dialogue"][_progression].size()-1 and $girl_zombie.progression == 2:
		happy_halloween.emit("girl")
		if !stats["save_data"]["akamaru_skins"]["pumpkin"]:
			stats["save_data"]["akamaru_skins"]["pumpkin"] = true
			@warning_ignore("narrowing_conversion")
			sounds.play_sfx("pickup", randf_range(0.6,1.4), -10)
			popup.emit("Unlocked Pumpkin Akamaru. Available for customization soon.")
			SaveAndLoad.update_save_data()
