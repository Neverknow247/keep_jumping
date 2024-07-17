extends Npc_Controller

@onready var knight = $knight
@onready var position_1 = $position_1
@onready var position_2 = $position_2
@onready var position_3 = $position_3
@onready var position_4 = $position_4

func _ready():
	super()
	_on_knight_set_up_mage()

func _on_knight_set_up_mage():
	match stats["save_data"]["mage_progression"]:
		0:
			knight.global_position = position_1.global_position
			knight.animated_sprite_2d.play("sleep")
		1:
			knight.global_position = position_2.global_position
			knight.animated_sprite_2d.play("idle_side")
			knight.scale.x = -1
		2:
			knight.global_position = position_3.global_position
			knight.animated_sprite_2d.play("idle_forward")
		3:
			knight.global_position = position_4.global_position
			knight.animated_sprite_2d.play("idle_forward")
		4:
			knight.global_position = position_4.global_position
			knight.animated_sprite_2d.play("idle_forward")
		5:
			knight.global_position = position_4.global_position
			knight.animated_sprite_2d.play("idle_forward")
		6:
			knight.global_position = position_4.global_position
			knight.animated_sprite_2d.play("idle_forward")
