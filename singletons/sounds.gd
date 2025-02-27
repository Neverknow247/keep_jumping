extends Node

@onready var sfx_players = $sfx.get_children()
@onready var music_players = $music.get_children()
#@onready var music_players = {
	#"music_main":$music_main,
	#"music_beat":$music_beat,
	#"music_lead":$music_lead
#}
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
	"hurt_1" : load(sfx_path+"hurt_1.wav"),
	"hurt_2" : load(sfx_path+"hurt_2.wav"),
	"hurt_3" : load(sfx_path+"hurt_3.wav"),
	"hurt_4" : load(sfx_path+"hurt_4.wav"),
	"hurt_5" : load(sfx_path+"hurt_5.wav"),
	"hurt_6" : load(sfx_path+"hurt_6.wav"),
	"hurt_7" : load(sfx_path+"hurt_7.wav"),
	"hurt_8" : load(sfx_path+"hurt_8.wav"),
	"hurt_9" : load(sfx_path+"hurt_9.wav"),
	"hurt_10" : load(sfx_path+"hurt_10.wav"),
	"hurt_11" : load(sfx_path+"hurt_11.wav"),
	"hurt_12" : load(sfx_path+"hurt_12.wav"),
	"hurt_13" : load(sfx_path+"hurt_13.wav"),
	"hurt_14" : load(sfx_path+"hurt_14.wav"),
	"hurt_15" : load(sfx_path+"hurt_15.wav"),
	"hurt_16" : load(sfx_path+"hurt_16.wav"),
	"hurt_17" : load(sfx_path+"hurt_17.wav"),
	"hurt_18" : load(sfx_path+"hurt_18.wav"),
	"hurt_19" : load(sfx_path+"ty_hurt.mp3"),
	"chain_step_1" : load(sfx_path+"chain_step_1.wav"),
	"chain_step_2" : load(sfx_path+"chain_step_2.wav"),
	"chain_damage_1" : load(sfx_path+"chain_damage_1.wav"),
	"chain_damage_2" : load(sfx_path+"chain_damage_2.wav"),
	"intro_sound" : load(sfx_path+"intro_sound.wav"),
	"tellyin" : load(sfx_path+"teleporterin.wav"),
	"tellyout" : load(sfx_path+"teleporterout.wav"),
	"glass" : load(sfx_path+"glass_1.wav"),
	"door_open" : load(sfx_path+"door_open.wav"),
	"door_close" : load(sfx_path+"door_close.wav"),
	"stone_door" : load(sfx_path+"stone_door.mp3"),
	"bell_bronze_ring" : load(sfx_path+"bell_bronze_ring.wav"),
	"bell_silver_ring" : load(sfx_path+"bell_silver_ring.wav"),
	"bell_gold_ring" : load(sfx_path+"bell_gold_ring.wav"),
	"air_recovery" : load(sfx_path+"air_recovery.wav"),
	"coin_collect" : load(sfx_path+"coin_collect.mp3"),
	"wilhelm_scream" : load(sfx_path+"wilhelm_scream.mp3"),
	"explosion_sound" : load(sfx_path+"explosion_sound.mp3"),
	"random_scream" : load(sfx_path+"random_scream.mp3"),
	"liquid_death" : load(sfx_path+"liquid_death.mp3"),
	"burn_death" : load(sfx_path+"burn_death.mp3"),
	"meow_1" : load(sfx_path+"meow_1.mp3"),
	"meow_2" : load(sfx_path+"meow_2.mp3"),
	"meow_3" : load(sfx_path+"meow_3.mp3"),
	"meow_4" : load(sfx_path+"meow_4.mp3"),
	"meow_5" : load(sfx_path+"meow_5.mp3"),
	"meow_6" : load(sfx_path+"meow_6.mp3"),
	"meow_7" : load(sfx_path+"meow_7.mp3"),
	"meow_8" : load(sfx_path+"meow_8.mp3"),
	"meow_9" : load(sfx_path+"meow_9.mp3"),
	"meow_10" : load(sfx_path+"meow_10.mp3"),
	"meow_11" : load(sfx_path+"meow_11.mp3"),
	"meow_12" : load(sfx_path+"meow_12.mp3"),
	"meow_13" : load(sfx_path+"meow_13.mp3"),
	"meow_14" : load(sfx_path+"meow_14.mp3"),
	"meow_15" : load(sfx_path+"meow_15.mp3"),
	"meow_16" : load(sfx_path+"meow_16.mp3"),
	"meow_17" : load(sfx_path+"meow_17.mp3"),
	"meow_18" : load(sfx_path+"meow_18.mp3"),
	"meow_19" : load(sfx_path+"meow_19.mp3"),
	"meow_20" : load(sfx_path+"meow_20.mp3"),
	"extended_meow" : load(sfx_path+"meow_extended.mp3"),
#	"" : load(sfx_path+".wav"),
	}

var music = {
	"doggo2" : load(music_path+"doggo2.wav"),
	"music_original" : load(music_path+"music_original.wav"),
	"main" : load(music_path+"main_rhythm.wav"),
	"slow_beat" : load(music_path+"slow_beat.wav"),
	"slow_lead" : load(music_path+"slow_lead.wav"),
	"fast_beat" : load(music_path+"fast_beat.wav"),
	"fast_lead" : load(music_path+"fast_lead.wav"),
	"space" : load(music_path+"fallenspace.wav"),
	"credits" : load(music_path+"credits.wav"),
	"challenge" : load(music_path+"sirtunnel.wav"),
	"training_challenge" : load(music_path+"training_challenge.wav"),
	"arcade_challenge" : load(music_path+"arcade_challenge.wav"),
	"secret_challenge" : load(music_path+"secret_challenge.wav"),
	"space_challenge" : load(music_path+"space_challenge.wav"),
	"dlc_bell_bronze" : load(music_path+"dlc_bell_bronze.wav"),
	"dlc_bell_silver" : load(music_path+"dlc_bell_silver.wav"),
	"dlc_bell_gold" : load(music_path+"dlc_bell_gold.wav"),
	"dlc_credits" : load(music_path+"dlc_credits.wav"),
	"dlc_main_music" : load(music_path+"dlc_main_music.wav"),
	"dlc_dark" : load(music_path+"dlc_dark.wav"),
	"dlc_sand" : load(music_path+"dlc_sand.wav"),
	"dlc_lava" : load(music_path+"dlc_lava.wav"),
	"sir_hallow" : load(music_path+"sir_hallow.wav"),
	"sir_the_season_city" : load(music_path+"sir_the_season_city.wav"),
	"sir_the_season_level" : load(music_path+"sir_the_season_level.wav"),
#	"" : load(music_path+".wav"),
}

var voice = {
	"angel_1_1" : load(voice_path+"angel_1_1.wav"),
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
	#print("Too many sounds playing")

#func play_music(music_string, pitch_scale = 1, volume_db = 0, player = "music_main"):
	#if music_playing != music_string:
		#music_players[player].pitch_scale = pitch_scale
		#music_players[player].volume_db = volume_db
		#music_players[player].stream = music[music_string]
		#music_players[player].play()
		#music_playing = music_string

func load_starting_music(music_list, pitch_scale, volume_db):
	stop_music()
	for i in music_list.size():
		music_players[i].pitch_scale = pitch_scale
		music_players[i].volume_db = volume_db
		music_players[i].stream = music[music_list[i]]
		music_players[i].play()

func play_music(music_string, music_player, pitch_scale = 1, volume_db = 0):
	if !music_player.is_playing():
		music_player.pitch_scale = pitch_scale
		music_player.volume_db = volume_db
		music_player.stream = music[music_string]
		music_player.play()

func stop_music():
	for music_player in music_players:
		music_player.stop()

func fade_in_music(music_string, pitch_scale = 1, volume_db = 0,fade_time = 5):
	var available_player = null
	for music_player in music_players:
		if music_player.stream == music[music_string]:
			available_player = music_player
			break
		elif !music_player.playing:
			available_player = music_player
	if available_player:
		play_music(music_string,available_player,pitch_scale,-80)
		if !available_player.volume_db == volume_db:
			var tween = get_tree().create_tween()
			tween.tween_property(available_player,"volume_db",volume_db,fade_time)
			#print("not loud enough yet")
		else:
			pass
			#print("already loud enough")
	else:
		pass
		#print("Too many songs playing")

@warning_ignore("unused_parameter")
func fade_out_music(music_string, pitch_scale = 1, volume_db = -80):
	var available_player = null
	for music_player in music_players:
		if music_player.stream == music[music_string]:
			available_player = music_player
			break
	if available_player:
		if !available_player.volume_db == volume_db:
			var tween = get_tree().create_tween()
			tween.tween_property(available_player,"volume_db",volume_db,5)
			#print("not quiet enough yet")
		else:
			pass
			#print("already quiet enough")
	else:
		pass
		#print("not playing")

func play_voice(voice_string, pitch_scale = 1, volume_db = 0):
	if voice_player.playing:
		voice_player.stop()
	voice_player.pitch_scale = pitch_scale
	voice_player.volume_db = volume_db
	voice_player.stream = voice[voice_string]
	voice_player.play()
