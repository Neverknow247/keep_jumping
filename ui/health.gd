extends Control

var stats = Stats

@onready var full = $full
@onready var empty = $empty

func _ready():
	set_mode()
	set_health()
	stats.connect("player_health_updated", update_health_ui)

func set_mode():
	if !stats["cheats"]["hp"]:
		if stats.mode == "ninja_dog" || stats.mode == "ninja_dash" || stats.mode == "iron_ninja":
			self.visible = false

func set_health():
	empty.size.x = stats.player_max_health *135 + 6
	full.size.x = stats.player_health * 135 + 6

func update_health_ui(value):
	full.size.x = value * 135 + 6
