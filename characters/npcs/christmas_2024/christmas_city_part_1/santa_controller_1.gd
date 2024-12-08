extends Npc_Controller

var sounds = Sounds

signal popup(text)

func _ready():
	if stats["save_data"]["santa_progression"] == 0 and stats["save_data"]["challenge_data"]["challenge_47"]["_normal_reunions"] >= 1: 
		$santa.progression = 0
	elif stats["save_data"]["santa_progression"] == 1:
		$santa.progression = 5
	else:
		$santa.progression = 1

func _on_talk(_progression):
	super(_progression)
	if progression > dialogue_script["dialogue"][_progression].size()-1 and $santa.progression == 0:
		$santa.progression = 2
		progression = 100
	elif progression > dialogue_script["dialogue"][_progression].size()-1 and $santa.progression == 1:
		$santa.progression = 2
		progression = 100
	elif progression > dialogue_script["dialogue"][_progression].size()-1 and $santa.progression == 2:
		$santa.progression = 3
		progression = 100
	elif progression > dialogue_script["dialogue"][_progression].size()-1 and $santa.progression == 4:
		if stats["save_data"]["armors"]["santa_2"] == false:
			stats["save_data"]["armors"]["santa_2"] = true
			@warning_ignore("narrowing_conversion")
			sounds.play_sfx("pickup", randf_range(0.6,1.4), -10)
			popup.emit("Don the beard and hat!")
		else:
			pass
	elif progression > dialogue_script["dialogue"][_progression].size()-1 and $santa.progression == 5:
		if stats["save_data"]["armors"]["santa_2"] == false:
			stats["save_data"]["armors"]["santa_2"] = true
			@warning_ignore("narrowing_conversion")
			sounds.play_sfx("pickup", randf_range(0.6,1.4), -10)
			popup.emit("Don the beard and hat!")
		else:
			pass

#signal happy_halloween(character)

#func _on_talk(_progression):
	#super(_progression)
	#if progression > dialogue_script["dialogue"][_progression].size()-1 and $girl_zombie.progression == 0:
		#if stats["save_data"]["akamaru_skins"]["glasses"]:
			#$girl_zombie.progression = 2
		#else:
			#$girl_zombie.progression = 1
	#elif progression > dialogue_script["dialogue"][_progression].size()-1 and $girl_zombie.progression == 1:
		#$girl_zombie.progression = 2
	#elif progression > dialogue_script["dialogue"][_progression].size()-1 and $girl_zombie.progression == 2:
		#happy_halloween.emit("girl")
		#if !stats["save_data"]["akamaru_skins"]["pumpkin"]:
			#stats["save_data"]["akamaru_skins"]["pumpkin"] = true
			#@warning_ignore("narrowing_conversion")
			#sounds.play_sfx("pickup", randf_range(0.6,1.4), -10)
			#popup.emit("Unlocked Pumpkin Akamaru. Available for customization soon.")
			#SaveAndLoad.update_save_data()

#func _on_talk(_progression):
	#super(_progression)
	#if progression > dialogue_script["dialogue"][_progression].size()-1 and $girl_zombie.progression == 2:
		#$girl_zombie.progression = 3
		#stats["save_data"]["akamaru_skins"]["glasses"] = true
		#sounds.play_sfx("pickup", randf_range(0.6,1.4), -10)
		#popup.emit("Unlocked Glasses Akamaru. Available for customization soon.")

	#if progression > dialogue_script["dialogue"][_progression].size()-1 and $girl_zombie.progression == 2:
		#$girl_zombie.progression = 3
		#@warning_ignore("narrowing_conversion")
		#sounds.play_sfx("pickup", randf_range(0.6,1.4), -10)
		#popup.emit("One step in the grave. Unlocked Ghost Armor")
