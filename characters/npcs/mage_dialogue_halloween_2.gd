extends Resource

var states = ["default","mage_waving"]

var dialogue = [
	[
		["Hello sir",states[1]],
		["This forest is really weird.",states[1]],
		["I cant seem to figure out how it showed up. Maybe there are answers behind this door.",states[1]],
		#[],
	],
	[
		["Sir is that you?",states[1]],
		["I almost didnt sense you because you are a ghost.",states[1]],
		["Did something happen?",states[1]],
		["I'll cast a spell that will allow others to see and talk to you, but I am not sure if i can bring back your body.",states[1]],
	],
	[
		["I will work on a spell to bring back your body.",states[1]],
		["Maybe there are answers behind this door.",states[1]],
		["Dont worry. We will figure this mystery out",states[1]],
	],
	#[
		#["",states[0]],
	#],
]
