extends Resource

var states = ["default","kid_zombie_with_eye","kid_zombie_costume"]

var dialogue = [
	[
		["Look at this eye I found!",states[1]],
		["What's the matter? Did you get lost? You look like you want this eye I have.",states[1]],
		["You think you’re a hero, but I bet you can't even find your own dog!",states[1]],
		["You think you can just stroll in and demand MY eye?",states[1]],
		["How about you earn it by finding my Halloween costume first? If you can even handle finding all 3 parts!",states[1]],
	],
	[
		["Wow, you actually did it!?",states[1]],
		["I guess even a clumsy knight can get lucky once every hundred years.",states[2]],
		["I'll have granny unlock the basement so you can leave.",states[2]],
		["Okay bye loser!",states[2]],
	],
	[
		["Why are you still here?",states[2]],
		["Don't you have anything better to do than annoy a kid zombie?",states[2]],
	],
]
