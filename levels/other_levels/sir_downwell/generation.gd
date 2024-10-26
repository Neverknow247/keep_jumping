extends Node2D
class_name Generator

var stats = Stats
var rng = stats.rng

var default_dungeon_size = 3
var rooms = default_dungeon_size
var dungeon = []
var dungeon_detailed = []
var dungeon_room = {
	"location":Vector2.ZERO,
	"north_door":false,
	"south_door":false,
	"east_door":false,
	"west_door":false,
	"starting_room":false,
	"exit_room":false,
	"room_type":0
}
var door_locations = [[Vector2(13,0),Vector2(14,0)],[Vector2(13,15),Vector2(14,15)],[Vector2(27,7),Vector2(27,8)],[Vector2(0,7),Vector2(0,8)]]
var door_names = ["north_door","south_door","east_door","west_door"]
var directions = [Vector2(0,1)]
#var directions = [Vector2(0,-1),Vector2(0,1),Vector2(1,0),Vector2(-1,0)]
var starting_room = Vector2.ZERO
var exit_room = Vector2.ZERO

func _ready():
	pass

func generate(dungeon_size = default_dungeon_size):
	rooms = dungeon_size
	starting_room = Vector2.ZERO
	dungeon.push_front(starting_room)
	var current_room = starting_room
	var counter = 0
	while dungeon.size() < rooms:
		var possible_directions = directions.duplicate()
		var next_room = Vector2.ZERO
		var good_room = false
		while !good_room:
			if possible_directions.size() == 0:
				counter+=1
				current_room = dungeon[counter]
				possible_directions = directions.duplicate()
			next_room = current_room+possible_directions.pop_at(rng.randi_range(0,possible_directions.size()-1))
			if next_room not in dungeon:
				dungeon.push_front(next_room)
				good_room = true
				current_room = next_room
				counter = 0
	exit_room = dungeon[0]
	for room in dungeon:
		if starting_room.distance_to(room)>starting_room.distance_to(exit_room):
			exit_room = room
	for room in dungeon:
		var new_room = dungeon_room.duplicate()
		new_room["location"] = room
		new_room["starting_room"] = room == starting_room
		new_room["exit_room"] = room == exit_room
		for i in directions.size():
			if room+directions[i] in dungeon:
				new_room[door_names[i]] = true
		dungeon_detailed.push_front(new_room)
	#print(dungeon)
	#print(JSON.stringify(dungeon_detailed,"\t",false))
