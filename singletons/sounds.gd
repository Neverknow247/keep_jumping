extends Node

@onready var sfx_players = $sfx.get_children()
@onready var music_player =$music
@onready var voice_player = $voice

var sfx_path = "res://assets/sfx/"
var music_path = "res://assets/music/"
var voice_path = "res://assets/voice/"

var sfx = {
	"smell_this_bread" : load(sfx_path+"smell_this_bread.wav"),
	"enemy_die" : load(sfx_path+"enemy_die.wav"),
	"player_hurt" : load(sfx_path+"player_hurt.wav"),
	"player_jump" : load(sfx_path+"player_jump.wav"),
	"step" : load(sfx_path+"step.wav"),
	"dig" : load(sfx_path+"dig.wav"),
	"bark_once" : load(sfx_path+"bark_once.wav"),
	"bark_twice" : load(sfx_path+"bark_twice.wav"),
	"pickup" : load(sfx_path+"pickup.wav"),
	"heal" : load(sfx_path+"heal.wav"),
	"bowl_bury" : load(sfx_path+"bowl_bury.wav"),
	"click" : load(sfx_path+"buttonClick.wav"),
#	"" : load(sfx_path+".wav"),
	}

var music = {
	"music_original" : load(music_path+"music_original.wav"),
	"music_original_reverse" : load(music_path+"music_original_reverse.wav"),
	"forest_stroll" : load(music_path+"forest_stroll.ogg"),
	"forest_stroll_reverse" : load(music_path+"forest_stroll_reverse.wav"),
	"shell_hop" : load(music_path+"shell_hop.ogg"),
	"shell_hop_reverse" : load(music_path+"shell_hop_reverse.wav"),
	"dog_house" : load(music_path+"dog_house.ogg"),
	"dog_house_reverse" : load(music_path+"dog_house_reverse.wav"),
	"dog_days" : load(music_path+"dog_days.ogg"),
#	"" : load(music_path+".wav"),
}

var voice = {
	"angel_1_1" : load(voice_path+"angel_1_1.wav"),
	"deneporood" : load(voice_path+"deneporood.wav"),
	"talking" : load(voice_path+"crowd_talking.mp3"),
	"talking_reversed" : load(voice_path+"crowd_talking_reversed.wav"),
#	"" : load(voice_path+".wav"),
}

var music_playing = null

func play_sfx(sfx_string, pitch_scale = 1, volume_db = 0):
	for sfx_player in sfx_players:
		if !sfx_player.playing:
			sfx_player.pitch_scale = pitch_scale
			sfx_player.volume_db = volume_db
			sfx_player.stream = sfx[sfx_string]
			sfx_player.play()
			return
	print("Too many sounds playing")

func play_music(music_string, pitch_scale = 1, volume_db = 0):
	if music_playing != music_string:
		music_player.pitch_scale = pitch_scale
		music_player.volume_db = volume_db
		music_player.stream = music[music_string]
		music_player.play()
		music_playing = music_string

func play_voice(voice_string, pitch_scale = 1, volume_db = 0):
	if voice_player.playing:
		voice_player.stop()
	voice_player.pitch_scale = pitch_scale
	voice_player.volume_db = volume_db
	voice_player.stream = voice[voice_string]
	voice_player.play()

