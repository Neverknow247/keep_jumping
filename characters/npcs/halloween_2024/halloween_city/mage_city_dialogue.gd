extends Resource

var states = ["default","mage_waving"]

var dialogue = [
	[
		["Sir, I found a way to bring back your body!",states[1]],
		["You need to collect 3 bones and bring them here to me.",states[1]],
		["Try retracing your steps to the different parts of the forest.",states[1]],
		#["Try retracing your steps in to different areas in the forest levels. Maybe some areas have opened up due to Halloween.",states[1]],
		#["",states[1]],
	],
	[
		["You have brought me enough bones.",states[1]],
		["I can cast a spell to remake your body.",states[1]],
		["You should get your legs back too!",states[1]],
		["Be sure to hear all 5 Happy Halloweens if you want access to Halloween Town!",states[1]],
	],
	[
		["Happy Halloween Sir!",states[1]],
		["Go on ahead and try to have some fun!",states[1]],
	],
	#[
		#["",states[1]],
	#],
]
