extends Resource

var states = ["default","girl_zombie_crying"]

var dialogue = [
	[
		["You are so close. I can sense my glasses nearby!",states[1]],
		["I also sense granny... be carefull...",states[1]],
		["She is gonna want to eat your strength",states[1]],
	],
	[
		["Oh no...",states[1]],
		["I told you to be carefull!",states[1]],
	],
	[
		["You found them!",states[0]],
		["Finally I can see again!",states[0]],
		["Thank you so much!",states[0]],
	],
	[
		["I'm so happy!",states[0]],
		["Visit my house later for trick or treating!",states[0]],
	],
	#[
		#["",states[0]],
	#],
]
