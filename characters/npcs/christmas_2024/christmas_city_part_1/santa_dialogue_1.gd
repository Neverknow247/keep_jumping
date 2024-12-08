extends Resource

var states = ["default","santa_defaut"]

var dialogue = [
	[
		["HO HO HO! You climbed all the way up there and forgot to activate the Candy Cane Beacon!",states[1]],
	],
	[
		["HO HO HO!",states[1]],
		["Welcome to Christmas City %s" %[Stats.logged_in_username],states[1]],
		["Don't look suprised, I know the names of all the people in the world.",states[1]],
		["As you can see, I seem to have gotten my sleigh stuck.",states[1]],
		["It's great you arrived when you did. I need your help to save Christmas!",states[1]],
	],
	[
		["Jack Frost is on his way here right now threatening to bring an eternal winter!",states[1]],
		["All of my elves are still preparing for Christmas. We haven't even put up the tree yet!",states[1]],
		["With my sleigh stuck, I am not able to call for reinforcements!",states[1]],
	],
	[
		["Please climb The Kringle Krag and activate the Candy Cane Beacon!",states[1]],
		["It's all up to you while I try to unstuck my sleigh!",states[1]],
		["HO HO HO!",states[1]],
	],
	[
		["You activated the beacon!",states[1]],
		["All the elves will sense the beacon like a warm glass of milk, HO HO HO!",states[1]],
		["Best prepare yourself for a battle, Jack Frost has a strong power over ice!",states[1]],
		["I can sense his power swirling high above the clouds.",states[1]],
	],
	[
		["HO HO HO! You activated the beacon!",states[1]],
		["The elves should take about a week to get here.",states[1]],
		["In the meantime, I need to get this sleigh in working order and then continue getting ready for Christmas!",states[1]],
		["When the elves arrive, I might need your help again!",states[1]],
	],
	#[
		#["",states[1]],
	#],
]
