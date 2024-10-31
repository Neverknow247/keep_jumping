extends Resource

var states = ["default","zombie_lost_eye","zombie_found_eye"]

var dialogue = [
	[
		["AHHHHHHHHHUEAHH!!! I…",states[1]],
		["I… lost my eye!",states[1]],
		["I was passing through when I lost my eye. Last place I remember having it was in the forest above",states[1]],
		["Please can you find my lost eye. I need it to see the 3rd dimension",states[1]],
		["AAAAHUH!",states[1]],
	],
	[
		["Ughhhhh",states[1]],
		["You found my eye!!",states[1]],
		["Now I can finally see the 3rd dimension again!",states[2]],
		["I'm so hungry",states[2]],
		["AAHHHUUUUGGGG!!",states[2]],
	],
	[
		["eeeehhhh",states[2]],
		["...so hungry...",states[2]],
		["...mmmmmm...",states[2]],
	],
]
