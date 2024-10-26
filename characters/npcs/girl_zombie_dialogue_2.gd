extends Resource

var states = ["default","girl_zombie_crying"]

var dialogue = [
	[
		["Waahhhhh",states[1]],
		["I'm still lost!",states[1]],
		["I need my glasses",states[1]],
		["Please, I am not supposed to talk to strangers, but I need my glasses.",states[1]],
		["Please find them for me.",states[1]],
		["I'm scared...",states[1]],
	],
	[
		["I wonder where that stranger went?",states[0]],
		["I miss my friends. Im so scared",states[0]],
	],
	[
		["Stranger, you are back! I didn't know you were a ghost this whole time!",states[0]],
		["You didnt find my glasses...",states[0]],
		["I think I lost them deeper in the forest, behind the forest door.",states[0]],
		["You can have this key. It will open the door.",states[0]],
		["Please find my glasses...",states[0]],
	],
	[
		["Waahhhhh",states[0]],
		["I miss my friends",states[0]],
	],
	#[
		#["",states[0]],
	#],
]
