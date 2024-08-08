extends StaticBody2D

var stats = Stats
var sounds = Sounds

var rng = RandomNumberGenerator.new()
var crown_rng_number = 42

@onready var animation_player = $AnimationPlayer

signal popup(text)

func _on_collect_coin_area_body_entered(body):
	var rand = rng.randi_range(1,1000)
	if rand == crown_rng_number:
		animation_player.play("animate")
		#popup.emit("Crown Collected")
		@warning_ignore("narrowing_conversion")
		sounds.play_sfx("coin_collect", randf_range(0.6,1.4), -10)
		stats["save_data"]["stats"]["Crowns"] += 1
