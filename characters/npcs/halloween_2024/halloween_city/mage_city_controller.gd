extends Npc_Controller

var sounds = Sounds

signal heal_player
@warning_ignore("unused_signal")
signal popup(text)
signal happy_halloween(character)

func _ready():
	if stats.calc_total_halloween_bones() >= 3:
		$mage.progression = 1

func _on_talk(_progression):
	super(_progression)
	if progression > dialogue_script["dialogue"][_progression].size()-1 and $mage.progression == 0 and stats.calc_total_halloween_bones() >= 3:
		$mage.progression = 1
	elif progression > dialogue_script["dialogue"][_progression].size()-1 and $mage.progression == 1:
		$mage.progression = 2
		heal_player.emit()
	elif progression > dialogue_script["dialogue"][_progression].size()-1 and $mage.progression == 2:
		happy_halloween.emit("mage")
