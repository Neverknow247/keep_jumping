extends Npc_Controller

var sounds = Sounds
signal popup(popup_text)

func _ready():
	super()
	#print( stats["save_data"]["challenge_data"]["challenge_35"]["_normal_reunions"]>0)
	if stats["save_data"]["zombie_progression"] == 1:
		$halloween_zombie.progression = 1
	elif stats["save_data"]["zombie_progression"] == 2:
		$halloween_zombie.progression = 2
		$halloween_zombie/AnimatedSprite2D.play("idle_2")

func _on_talk(_progression):
	super(_progression)
	if progression > dialogue_script["dialogue"][_progression].size()-1 and $halloween_zombie.progression == 1:
		$halloween_zombie.progression = 2
		stats["save_data"]["zombie_progression"] = 2
		if stats["save_data"]["armors"]["pumpkin"] == false:
			stats["save_data"]["armors"]["pumpkin"] = true
			@warning_ignore("narrowing_conversion")
			sounds.play_sfx("pickup", randf_range(0.6,1.4), -10)
			popup.emit("Embody the spirit of autumn. Unlocked Pumpkin Head Armor")
		SaveAndLoad.update_save_data()
